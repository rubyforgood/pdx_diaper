ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  page_action :update_metrics, method: :post do
    start_date = Date.strptime(params[:event][:starts_at], "%Y-%m-%d")
    end_date = Date.strptime(params[:event][:ends_at], "%Y-%m-%d")
    if start_date > end_date
      redirect_to root_path, alert: "You must enter a valid date range"
    else
      redirect_to root_path(:start_date => params[:event][:starts_at], :end_date => params[:event][:ends_at])
    end
  end

  sidebar :filter do
    form_for :event, url: dashboard_update_metrics_path, html: { class: "filter_form" } do |f|
      div class: "date_range input filter_form_field filter_date_range" do
        f.label :by_date, class: "label"
        f.text_field :starts_at, as: :datepicker, class: "datepicker hasDatetimePicker dashboardDatePicker", size: 12, maxlength: 10, value: (default_start_date).strftime('%Y-%m-%d')
        span "-", class: "seperator"
        f.text_field :ends_at, as: :datepicker, class: "datepicker hasDatetimePicker dashboardDatePicker", size: 12, maxlength: 10, value: DateTime.now.strftime('%Y-%m-%d')
      end
      div class: "buttons" do
        f.submit "Update Filter"
      end
    end
  end

  content title: proc{ I18n.t("active_admin.dashboard") } do
    if !params[:start_date].blank?
      start = DateTime.strptime(params[:start_date], "%Y-%m-%d").beginning_of_day
    else
      start = default_start_date
    end
    if !params[:end_date].blank?
      date_end = DateTime.strptime(params[:end_date], "%Y-%m-%d").end_of_day
    else
      date_end = default_end_date
    end
    panel "Snapshot for #{start.strftime('%D')} - #{date_end.strftime('%D')}" do
      columns do
        column do
          render partial: 'dashboard/snapshot', locals: { :type => "Donated", data: container_quantity_by_type("Donation", start, date_end) }
        end
        column do
          render partial: 'dashboard/snapshot', locals: { :type => "Ticketed", data: container_quantity_by_type("Ticket", start, date_end) }
        end
      end
    end
    columns do
      column do
        inventories = Inventory.all.collect { |i| i.name }
        data = Item.joins(:holdings)
          .includes(holdings: :inventory)
          .group("items.name", "inventories.name")
          .order("items.name, inventories.name")
          .sum("holdings.quantity")
        all_items = data.each_with_object({}) do |(keys, quantity), memo|
          item_name, inventory_name = keys
          memo[item_name] ||= {}
          memo[item_name][inventory_name] = quantity
        end
        panel "Inventory Summary" do
          render partial: "inventories/inventory_dashboard_summary", object: all_items, as: :items, locals: { inventories: inventories }
        end

        panel "Inventory Charts" do
          render partial: 'metrics/inventory_charts', locals: {  }
        end
      end
      column do
        panel "Donation Totals" do
          para do
            render partial: 'donation_stats', :locals => {:start_date => start, :end_date => date_end }
          end
        end
        panel "Ticket Totals" do
          para do
            render partial: 'ticket_stats', :locals => {:start_date => start, :end_date => date_end, :dropoffs => dropoff_totals(start, date_end) }
          end
        end
        panel "Donation Charts" do
          ####
          # TODO: These generate a bunch of individual counts because it's querying day by day.
          # Not sure how to group the day results together to avoid n+1 but it's worth
          # exploring that to make this query more efficient.
          ####
          render partial: 'metrics/charts', locals: { :start_date => start, :end_date => date_end }
        end
      end
    end
  end
end

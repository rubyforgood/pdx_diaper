ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  page_action :update_metrics, method: :post do
    redirect_to root_path(:start_date => params[:event][:starts_at], :end_date => params[:event][:ends_at])
  end

  sidebar :options do
      form_for :event, { :url => dashboard_update_metrics_path } do |f|
        div do
          f.label :starts_at
          f.text_field :starts_at, :as => :datepicker, :class => "datepicker hasDatetimePicker dashboardDatePicker", :value  => (default_start_date).strftime('%Y-%m-%d')
        end
        div do
          f.label :ends_at
          f.text_field :ends_at, :as => :datepicker, :class => "datepicker hasDatetimePicker dashboardDatePicker", :value  => default_end_date.strftime('%Y-%m-%d')
        end
        f.submit "Update Date Range"
      end
    end

  content title: proc{ I18n.t("active_admin.dashboard") } do
    columns do
      column do
        inventories = Inventory.all.collect { |i| i.name }
        all_items = {}
        
        # 
        Holding.includes(:inventory).includes(:item).all.each do |h|
          all_items[h.item.name] ||= {}
          all_items[h.item.name][h.inventory.name] = h.quantity
        end
        sorted_items = {}
        all_items.each do |i, h|
          sorted_items[i] = {}
          inventories.each { |inv| sorted_items[i][inv] = 0 }
          h.each { |name,qty| sorted_items[i][name] = qty }
        end
        panel "Inventory Summary" do
            render partial: "inventories/inventory_dashboard_summary", object: all_items, as: :items, locals: { inventories: inventories }
        end
      end
      column do
        if !params[:start_date].blank?
          start = Date.strptime(params[:start_date], "%Y-%m-%d")
        end
        if !params[:end_date].blank?
          date_end = Date.strptime(params[:end_date], "%Y-%m-%d")
        end
        panel "Donation Totals" do
          para do
            render partial: 'donation_stats', :locals => {:start_date => start, :end_date => date_end, :dropoffs => dropoff_totals(start, date_end) }
          end
        end
        panel "Ticket Totals" do
          para do
            render partial: 'ticket_stats', :locals => {:start_date => start, :end_date => date_end, :dropoffs => dropoff_totals(start, date_end) }
          end
        end
      end
    end
  end # content
end

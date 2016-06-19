ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  sidebar :options do
      form_for :date, { :url => "#" } do |f|
        div do
          f.label :starts_at
          f.input :starts_at, :as => :datepicker, :class => "datepicker hasDatetimePicker", :value  => (Date.today - 1.year).strftime('%Y-%m-%d')
        end
        div do
          f.label :ends_at
          f.input :ends_at, :as => :datepicker, :class => "datepicker hasDatetimePicker", :value  => Date.today.strftime('%Y-%m-%d')
        end
      end
    end

  content title: proc{ I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "Inventory Summary" do
            inventories = Inventory.all

            
        end
      end
     column do
        panel "Quick Summary" do
          para do
            h3 "Donation Totals"
            h5 "Totals By Source:" 
            ul do
              li "Diaper Drive: #{diaper_totals_by_source('Diaper Drive')}"
              li "Purchased Supplies: #{diaper_totals_by_source('Purchased Supplies')}"
              li "Donation Pickup Location: #{diaper_totals_by_source('Donation Pickup Location')}"
            end
            h5 "Totals By Location:" 
            ul do
              totals = dropoff_totals
              totals.each do |key, value|
                li "#{key}: #{value}"
              end
            end
            h3 "Ticket Totals"

          end
        end
      end
    end
  end # content
end

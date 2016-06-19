ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    section "Filter", :priority => 4 do
      div do

      end
    end
    columns do
      column do
        panel "Inventory Summary" do
            inventories = Inventory.all

            
        end
      end
     column do
        panel "Quick Summary" do
          para do
            h4 "Donation Totals"
            ul "Totals By Source:" do
              li "Diaper Drive: #{diaper_totals_by_source('Diaper Drive')}"
              li "Purchased Supplies: #{diaper_totals_by_source('Purchased Supplies')}"
              li "Donation Pickup Location: #{diaper_totals_by_source('Donation Pickup Location')}"
            end
            ul "Totals By Location:" do
              totals = dropoff_totals
              totals.each do |key, value|
                li "#{key}: #{value}"
              end
            end
            h4 "Ticket Totals"

          end
        end
      end
    end
  end # content
end

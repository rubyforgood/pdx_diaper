ActiveAdmin.register Donation do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
permit_params :source, :dropoff_location_id
sources = ["Diaper Drive", "Purchased Supplies", "Donation Pickup Location"]

form do |f|
	inputs 'Create new Donation' do
    input :dropoff_location_id, :label => 'Dropoff Location', :as => :select, :collection => DropoffLocation.all
    input :source, :label => 'Source', :as => :select, :collection => sources
  	actions
  end
end

index do
  selectable_column
  column "Receipt Number", :id
  column :source
  column :updated_at
  column :created_at
  actions
end

  show do
    attributes_table do
      row('Receipt Number'){ |d| d.id }
      row :source
      row :dropoff_location
      row :completed
      row :created_at
      row :updated_at
      row "Items" do |donation|
        donation.containers.each do |c|
          attributes_table_for c do
            row :quantity
            row :category
            row :item
          end
        end
        nil
      end
      div do
        form_for :container, { :url => add_item_donation_path } do |f|
          div do
            f.label :category
            f.text_field :category
          end
          div do
            f.label :quantity
            f.text_field :quantity
          end
          div do
            f.label :item
            f.select("item_id", Item.all.collect { |i| [i.name, i.id] } )
          end
            f.submit
          end
        end
      end
    end
  member_action :add_item, method: :post do
    donation=Donation.find(params[:id])
    item=Item.find(params[:container][:item_id])
    donation.track(item,params[:container][:quantity].to_i)
    redirect_to donation_path(params[:id])
  end
end
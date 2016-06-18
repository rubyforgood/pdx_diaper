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


end

ActiveAdmin.register Ticket do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :partner_id
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

form do |f|
  inputs 'Partner' do
    input :partner_id, :label => 'Partner', :as => :select, :collection => Partner.all
  end
  inputs 'Items', for: :containers do | container |
    container.input :item_id, :label => 'Items', :as => :select, :collection => Item.all
    container.input :quantity
  end
    actions
end

show do |ticket|
  attributes_table do
    row :partner
    row :created_at
    row :items
  end
  panel "Items" do
     ul do
      ticket.containers.each do |container|
        li [container.item.name, container.quantity].join ", "
      end
     end
  end
end

end

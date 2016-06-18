ActiveAdmin.register Ticket do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :partner_id, :containers_attributes => [:item_id, :quantity, :id, :_destroy]
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

  controller do
    def create
      inventory = Inventory.find(params[:ticket][:inventory_id])
      @ticket = inventory.distribute!(item_params)
      create!
    end

    def item_params
      params["ticket"]["containers_attributes"].values.map { |entry| 
        [ entry["item_id"], entry["quantity"].to_i ] 
      }.to_h
    end
  end


form do |f|
  inputs do
    input :partner_id, :label => 'Partner', :as => :select, :collection => Partner.all
    input :inventory, :label => 'Storage Facility', :as => :select, :collection => Inventory.all
  end
  inputs 'Items' do
    f.has_many :containers, allow_destroy: true do |container|
      container.input :item_id, :label => 'Items', :as => :select, :collection => Item.all
      container.input :quantity
    end
  end
  actions
end

show do |ticket|
  attributes_table do
    row :partner
    row :created_at
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

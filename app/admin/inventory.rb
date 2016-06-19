# == Schema Information
#
# Table name: inventories
#
#  id         :integer          not null, primary key
#  name       :string
#  address    :string
#  created_at :datetime
#  updated_at :datetime
#
# (modified 18 June 2016)

ActiveAdmin.register Inventory do

  menu parent: "Inventory", label: "Storage Locations"

  permit_params :name, :address

  filter :name
  filter :address
  filter :items, label: "Locations that have"
  filter :created_at
 
  index do
    selectable_column
    column :name do |inventory|
      link_to inventory.name, inventory
    end
    column :address
    column :total_inventory do |inventory|
      "#{inventory.total_inventory} items"
    end
    actions
  end

  show do
    
    attribute, direction = params[:order].try(:split,"_") || [nil,nil]

    @inventory = Inventory.includes(:holdings => :item).order("#{attribute} #{direction}").find(resource.id)

    attributes_table do
      row :name
      row :address
    end

    panel "Items at this location" do
      table_for @inventory.holdings, sortable: true do
        column "Item", sortable: "items.name" do |holding|
          link_to holding.item.name, holding.item
        end
        column :quantity, sortable: "holdings.quantity"
      end
    end
  end
end

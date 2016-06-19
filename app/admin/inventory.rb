ActiveAdmin.register Inventory do
  permit_params :name, :address

  index do
    selectable_column
    column :name do |inventory|
      link_to inventory.name, inventory
    end
    column :address
    column :total_inventory do |inventory|
      "#{inventory.total_inventory} diapers"
    end
    column :created_at
    column :updated_at
    actions
  end

  show do
    @items = Inventory.includes(:holdings).where(id: resource.id).first.items

    attributes_table do
      row :name
      row :address
    end

    panel "Items at this location" do
      table_for inventory.holdings do
        column "Item" do |holding|
          link_to holding.item.name, holding.item
        end
        column :quantity
      end
    end
  end
end

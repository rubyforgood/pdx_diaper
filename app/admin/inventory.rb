ActiveAdmin.register Inventory do
  permit_params :name, :address

  show do |inventory|
  	@items = Inventory.includes(:holdings).where(id: resource.id).first.items
    
    attributes_table do
    	row :name
    	row :address
    end

    panel "Items at this location" do
      ul do
        inventory.holdings.each do |holding|
          li "#{holding.item.name} - #{holding.quantity}"
        end
      end
    end

  end
end

ActiveAdmin.register Inventory do
  permit_params :name, :address

  show do
  	@items = Inventory.includes(:holdings).where(id: resource.id).first.items
    
    attributes_table do
    	row :name
    	row :address
    end

    panel "Items at this location" do
    end

  end
end

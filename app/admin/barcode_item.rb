ActiveAdmin.register BarcodeItem do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :value, :item_id, :quantity

form do |f|
  inputs 'Add New Item' do
    f.input :item_id, :label => 'Item Type', :as => :select, :collection => Item.all
    f.input :quantity, :label => 'Quantity', :as => :string
    f.input :value, :label => 'Scan Barcode', :as => :string
    actions
  end
end

index do
  selectable_column
  column 'ID', :id
  column 'Item Type', :item_id
  column :quantity
  column :value
  actions
end


end

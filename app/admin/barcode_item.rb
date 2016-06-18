ActiveAdmin.register BarcodeItem do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :value, :item_id, :quantity

form do |f|
  inputs 'Add New Item' do
    input :item_id, :label => 'Item Type', :as => :select, :collection => Item.all
    input :quantity, :label => 'Quantity', :as => 
  end
end


end

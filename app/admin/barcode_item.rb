# == Schema Information
#
# Table name: barcode_items
#
#  id         :integer          not null, primary key
#  value      :string
#  item_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# (modified 18 June 2016)

ActiveAdmin.register BarcodeItem do

  menu parent: "Inventory", label: "Barcodes"

  permit_params :value, :item_id, :quantity

  filter :item
  filter :quantity
  filter :created_at

  form do |f|
    panel "Instructions" do
      ol do
        li "Select the item type (if it's not in the list, you'll need to create a new one"
        li "Type in how many of that item there are in the package (for '120 diapers' you would just write '120'"
        li "Click in the barcode field first, then scan the barcode with your reader"
      end
    end
    inputs 'Add New Item' do
      f.input :item
      f.input :quantity, label: 'Quantity in the Box'
      f.input :value, :label => 'Scan Barcode'
      actions
    end
  end

  index do
    selectable_column
    column 'Item Type', :item
    column "Quantity in the Box", :quantity
    column "Barcode", :value, sortable: false
    actions
  end


end

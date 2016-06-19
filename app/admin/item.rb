# == Schema Information
#
# Table name: items
#
#  id         :integer          not null, primary key
#  name       :string
#  category   :string
#  created_at :datetime
#  updated_at :datetime
#
# (modified 18 June 2016)


ActiveAdmin.register Item do

  menu parent: "Inventory", label: "Item types"

  permit_params :name, :category, :size, :barcode_items_attributes => [:id, :item_id, :quantity, :value]

  filter :inventories, label: "Stored In"
  filter :name
  filter :category, as: :select
  filter :created_at

  config.sort_order = "name_asc"

  index do
    selectable_column
    column :name
    column :category
    column "Barcode Entries" do |i|
      entries = BarcodeItem.where(item_id: i).count
      link_to_unless(entries == 0, entries, barcode_items_path("q[item_id_eq]": i, item_id_eq: i))
    end
    actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :category
      row :created_at
      row :updated_at
      row "BARCODES" do |item|
        if item.barcode_items.count > 0
          table_for resource.barcode_items do
            column :value
            column :quantity
          end
        end
      end
    end
  end

end

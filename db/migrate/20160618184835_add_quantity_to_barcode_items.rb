class AddQuantityToBarcodeItems < ActiveRecord::Migration
  def change
    add_column :barcode_items, :quantity, :integer
  end
end

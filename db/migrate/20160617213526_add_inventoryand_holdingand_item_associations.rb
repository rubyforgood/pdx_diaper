class AddInventoryandHoldingandItemAssociations < ActiveRecord::Migration
  def change
    add_column :holdings, :inventory_id, :integer
    add_column :holdings, :item_id, :integer
  end
end

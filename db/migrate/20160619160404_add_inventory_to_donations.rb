class AddInventoryToDonations < ActiveRecord::Migration
  def change
    add_reference :donations, :inventory, index: true, foreign_key: true
  end
end

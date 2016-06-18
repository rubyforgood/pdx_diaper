class AddFieldsToContainer < ActiveRecord::Migration
  def change
    add_column :containers, :donation_id, :integer
    add_column :containers, :item_id, :integer
  end
end

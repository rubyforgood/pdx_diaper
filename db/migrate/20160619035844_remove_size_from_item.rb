class RemoveSizeFromItem < ActiveRecord::Migration
  def change
  	remove_column :items, :size, :integer
  end
end

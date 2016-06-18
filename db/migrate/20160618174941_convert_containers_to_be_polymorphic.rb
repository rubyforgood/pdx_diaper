class ConvertContainersToBePolymorphic < ActiveRecord::Migration
  def change
    add_column :containers, :itemizable_id, :integer
    add_column :containers, :itemizable_type, :string

    add_index :containers, [:itemizable_id, :itemizable_type]

    remove_column :containers, :donation_id
    remove_column :containers, :category
  end
end

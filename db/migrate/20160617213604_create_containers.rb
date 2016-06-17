class CreateContainers < ActiveRecord::Migration
  def change
    create_table :containers do |t|
      t.string :category
      t.integer :quantity

      t.timestamps null: false
    end
  end
end

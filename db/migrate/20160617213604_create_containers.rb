class CreateContainers < ActiveRecord::Migration
  def change
    create_table :containers do |t|
      t.string :type
      t.integer :quantity

      t.timestamps null: false
    end
  end
end

class CreateHoldings < ActiveRecord::Migration
  def change
    create_table :holdings do |t|
      t.integer :quantity

      t.timestamps
    end
  end
end

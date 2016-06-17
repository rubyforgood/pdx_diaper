class CreateDonations < ActiveRecord::Migration
  def change
    create_table :donations do |t|
    	t.string :dropoff_location
    	t.string :source
    	t.string :receipt_number

      t.timestamps
    end
  end
end

class CreateDonations < ActiveRecord::Migration
  def change
    create_table :donations do |t|
    	t.string :dropoff_location
    	t.string :source

      t.timestamps
    end
  end
end

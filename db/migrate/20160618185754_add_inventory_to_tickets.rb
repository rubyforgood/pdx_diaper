class AddInventoryToTickets < ActiveRecord::Migration
  def change
    add_reference :tickets, :inventory, index: true, foreign_key: true
  end
end

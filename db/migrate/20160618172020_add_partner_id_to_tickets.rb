class AddPartnerIdToTickets < ActiveRecord::Migration
  def change
    add_reference :tickets, :partner, index: true, foreign_key: true
  end
end

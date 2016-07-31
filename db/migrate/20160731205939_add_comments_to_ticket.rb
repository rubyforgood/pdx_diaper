class AddCommentsToTicket < ActiveRecord::Migration
  def change
    add_column :tickets, :comment, :text
  end
end

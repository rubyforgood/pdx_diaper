# == Schema Information
#
# Table name: inventories
#
#  id         :integer          not null, primary key
#  name       :string
#  address    :string
#  created_at :datetime
#  updated_at :datetime
#

class Inventory < ActiveRecord::Base
  has_many :holdings
  has_many :tickets
  has_many :items, through: :holdings

  validates :name, presence: true
  validates :address, presence: true


  def intake!
  end
  
  def distribute!(items)
    ticket = Ticket.new(inventory: self)
    items.each do |item, quantity|
      field_name = item.is_a?(Item) ? :item : :item_id
      result = self.holdings.find_by(field_name => item)
      new_container = ticket.containers.build(field_name => item, quantity: quantity)
      if result.quantity > quantity
        result.quantity = result.quantity - quantity
      end
    end
  end
end

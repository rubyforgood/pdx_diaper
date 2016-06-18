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

  def self.item_total(item_id) 
  	Inventory.select('quantity').joins(:holdings).where('holdings.item_id = ?', item_id).collect { |h| h.quantity }.reduce(:+)
  end

  def item_total(item_id)
  	holdings.select(item_id: item_id).first.quantity
  end

  def size
  	holdings.collect { |h| h.quantity }.reduce(:+)
  end

  def intake!(donation)
  	log = {}
  	donation.containers.each do |container|
  		holding = Holding.find_or_create_by(inventory_id: self.id, item_id: container.item_id) do |holding|
  			holding.quantity = 0
  		end
  		holding.quantity += container.quantity rescue 0
  		holding.save
  		log[container.item_id] = "+#{container.quantity}"
  	end
  	log
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
    ticket
  end
end

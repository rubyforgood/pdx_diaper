# == Schema Information
#
# Table name: tickets
#
#  id           :integer          not null, primary key
#  created_at   :datetime
#  updated_at   :datetime
#  partner_id   :integer
#  inventory_id :integer
#

class Ticket < ActiveRecord::Base

  # Tickets are issued from a single inventory, so we associate them so that on-hand amounts can be verified
  belongs_to :inventory

  # Tickets are issued to a single partner
  belongs_to :partner

  # Tickets contain many different items
  has_many :containers, as: :itemizable
  has_many :items, through: :containers
  accepts_nested_attributes_for :containers, allow_destroy: true

  validates :inventory, :partner, presence: true
  validate :containers_do_not_exceed_inventory

  private

  def containers_do_not_exceed_inventory
    self.containers.each do |container|
      holding = self.inventory.holdings.find_by(item: container.item)
      if holding.nil? || holding.quantity == 0
        errors.add(:inventory, "#{container.item.name} is not available at this storage location")
        container.quantity = 0
      elsif holding.quantity < container.quantity
        container.quantity = holding.quantity
        errors.add(:inventory, "Adjusted quantity of #{container.item.name} to match available inventory of #{holding.quantity}")
      end
    end
  end
end

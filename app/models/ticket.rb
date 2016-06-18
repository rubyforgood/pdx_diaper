# == Schema Information
#
# Table name: tickets
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#

class Ticket < ActiveRecord::Base
  belongs_to :inventory
  belongs_to :partner
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

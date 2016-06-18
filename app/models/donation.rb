# == Schema Information
#
# Table name: donations
#
#  id                  :integer          not null, primary key
#  source              :string
#  receipt_number      :string
#  dropoff_location_id :integer
#  created_at          :datetime
#  updated_at          :datetime
#

class Donation < ActiveRecord::Base
  belongs_to :dropoff_location
  has_many :containers, as: :itemizable
  has_many :items, through: :containers

  validates :dropoff_location, presence: true
  validates :source, presence: true

  def track(item,quantity)
    Container.create(itemizable: self, item_id: item.id, quantity: quantity)
  end

  def total_items()
    self.containers.collect{ | c | c.quantity }.reduce(:+)
  end
end

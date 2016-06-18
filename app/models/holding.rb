# == Schema Information
#
# Table name: holdings
#
#  id         :integer          not null, primary key
#  quantity   :integer
#  created_at :datetime
#  updated_at :datetime
#

class Holding < ActiveRecord::Base
  belongs_to :inventory
  belongs_to :item

  validates :quantity, presence: true
  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 0}
end

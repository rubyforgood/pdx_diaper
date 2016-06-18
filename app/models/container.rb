# == Schema Information
#
# Table name: containers
#
#  id          :integer          not null, primary key
#  category    :string
#  quantity    :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  donation_id :integer
#  item_id     :integer
#

class Container < ActiveRecord::Base
  belongs_to :itemizable, polymorphic: true
  belongs_to :item

  validates :quantity, presence: true
end

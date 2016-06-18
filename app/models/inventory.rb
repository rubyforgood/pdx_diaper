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
  has_many :items, through: :holdings

  validates :name, presence: true
  validates :address, presence: true

  def intake!
  end
end

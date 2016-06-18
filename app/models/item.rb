# == Schema Information
#
# Table name: items
#
#  id         :integer          not null, primary key
#  name       :string
#  category   :string
#  size       :string
#  created_at :datetime
#  updated_at :datetime
#

class Item < ActiveRecord::Base
  has_many :containers
  has_many :holdings
  has_many :inventories, through: :holdings
  has_many :donations, through: :containers
  has_many :tickets, through: :containers
end

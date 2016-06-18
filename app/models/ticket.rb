# == Schema Information
#
# Table name: tickets
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#

class Ticket < ActiveRecord::Base
  has_one :partner
  has_many :containers, as: :itemizable
  has_many :items, through: :containers
end

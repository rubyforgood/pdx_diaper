# == Schema Information
#
# Table name: items
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  category   :string(255)
#  size       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Item < ActiveRecord::Base
  has_one :container
  has_one :holding
end

# == Schema Information
#
# Table name: holdings
#
#  id           :integer          not null, primary key
#  quantity     :integer
#  created_at   :datetime
#  updated_at   :datetime
#  inventory_id :integer
#  item_id      :integer
#

class Holding < ActiveRecord::Base
  belongs_to :inventory
  belongs_to :item
end

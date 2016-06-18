# == Schema Information
#
# Table name: containers
#
#  id              :integer          not null, primary key
#  quantity        :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  item_id         :integer
#  itemizable_id   :integer
#  itemizable_type :string
#

class Container < ActiveRecord::Base
  belongs_to :itemizable, polymorphic: true
  belongs_to :item

  validates :quantity, presence: true
end

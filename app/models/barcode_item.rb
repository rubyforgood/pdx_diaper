# == Schema Information
#
# Table name: barcode_items
#
#  id         :integer          not null, primary key
#  value      :string
#  item_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class BarcodeItem < ActiveRecord::Base
  belongs_to :item

  validates :value, presence: true, uniqueness: true
end

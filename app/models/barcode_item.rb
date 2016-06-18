class BarcodeItem < ActiveRecord::Base
  has_one :item

  validates :value, presence: true
end

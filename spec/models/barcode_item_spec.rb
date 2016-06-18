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

require 'rails_helper'

RSpec.describe BarcodeItem, type: :model do
  it "has a value" do
    barcode_item = build(:barcode_item, value: nil)
    expect(barcode_item).not_to be_valid
  end
  it "has a unique value" do
    barcode_item = create :barcode_item
    bad_barcode = build(:barcode_item, value: barcode_item.value)
    expect(bad_barcode).not_to be_valid
  end
end

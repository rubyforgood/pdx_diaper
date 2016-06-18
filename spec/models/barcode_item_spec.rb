require 'rails_helper'

RSpec.describe BarcodeItem, type: :model do
  it "has a value" do
    barcode_item = build(:barcode_item, value: nil)
    expect(barcode_item).not_to be_valid
  end
  it "has one item" do
    assc = described_class.reflect_on_association(:item)
    expect(assc.macro).to eq :has_one
  end
end

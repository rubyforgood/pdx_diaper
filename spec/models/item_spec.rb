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

require "rails_helper"

RSpec.describe Item, type: :model do
  it "has a name" do
    item = Item.create(name: "Diaper")
    expect(item.name).to_not be nil
  end

  it "has a category" do
    item = Item.create(category: "disposable")
    expect(item.category).to_not be nil
  end

  it "has a size" do
    item = Item.create(size: "small")
    expect(item.size).to_not be nil
  end

  it "has one container" do
    assc = described_class.reflect_on_association(:container)
    expect(assc.macro).to eq :has_one
  end

  it "has one holdings" do
    assc = described_class.reflect_on_association(:holding)
    expect(assc.macro).to eq :has_one
  end
end

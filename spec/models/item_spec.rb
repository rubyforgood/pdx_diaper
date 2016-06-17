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
end
require "rails_helper"

RSpec.describe Holding, type: :model do
	it "has a quantity" do
		holding = Holding.create(quantity: 0)
		expect(holding.quantity).to_not be nil
	end
  it "is an integer" do
    holding = Holding.create(quantity: 1)
    expect(holding.quantity).to be_a(Integer)
  end
  it "is not a negative number" do
    holding = Holding.create(quantity: 3)
    expect(holding.quantity). to be >= 0
  end
end

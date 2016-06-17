require "rails_helper"

RSpec.describe Container, type: :model do
	let(:container) { FactoryGirl.create :container }
	it "has a type" do
		expect(container.type).to_not be nil
	end
	it "has a quantity" do
		expect(container.quantity).to_not be nil
	end
	it "does not allow a quantity to not be present" do
		container = Container.new(quantity: nil)
		expect(container.valid?).to be false
	end
end
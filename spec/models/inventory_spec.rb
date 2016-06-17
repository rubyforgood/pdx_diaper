require "rails_helper"

RSpec.describe Inventory, type: :model do
	it "has a name" do
		inventory = Inventory.create(name: "Smithsonian Institute")
		expect(inventory.name).to_not be nil
	end
	it "has an address" do
		inventory = Inventory.create(address: "1500 Remount Road, Front Royal, VA")
		expect(inventory.address).to_not be nil
	end
end

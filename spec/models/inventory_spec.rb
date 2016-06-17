# == Schema Information
#
# Table name: inventories
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  address    :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require "rails_helper"

RSpec.describe Inventory, type: :model do
	it "has a name" do
		inventory = FactoryGirl.create :inventory
		expect(inventory.name).to_not be nil
	end
	it "has an address" do
		inventory = FactoryGirl.create :inventory
		expect(inventory.address).to_not be nil
	end
end

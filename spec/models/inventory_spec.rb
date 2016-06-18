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
		inventory = build(:inventory, name: nil)
		expect(inventory).not_to be_valid
	end
	it "has an address" do
		inventory = build(:inventory, address: nil)
		expect(inventory).not_to be_valid
	end
	it "has items" do
		inventory = create :inventory
		holding = create :holding
		item = create :item
		expect {
			holding.item = item
			inventory.holdings << holding
	}.to change{inventory.items.count}.by(1)
	end
end

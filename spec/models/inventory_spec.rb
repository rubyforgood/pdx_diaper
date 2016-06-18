# == Schema Information
#
# Table name: inventories
#
#  id         :integer          not null, primary key
#  name       :string
#  address    :string
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


	it "receives donations through intake method" do
		inventory = create :inventory
		donation = create :donation
		donation.items << create(item)
		expect{inventory.intake!(donation); inventory.reload}.to_change{inventory.items.count}.by(1)
	end

	it "distrbutes items from inventory" do
		inventory = create :inventory_with_items
		item = inventory.items.first
		result = inventory.distribute!(item => 50)
		expect(result).to be_a Ticket
		expect(result.containers.first.item).to eq item
		expect(result.containers.first.quantity).to eq 50 
	end

	it "does not distribute if insufficient inventory" do
		inventory = create :inventory_with_items
		item = inventory.items.first
		result = inventory.distribute!(item => 350)
		expect(result).to be_a Ticket
		expect(result).not_to be_valid
		expect(result.containers.first.item).to eq item
		expect(result.containers.first.quantity).to eq 300
		expect(result.errors).to include :inventory
		expect(result.errors[:inventory]).to include "Adjusted quantity of #{item.name} to match available inventory of 300" 
	end

end

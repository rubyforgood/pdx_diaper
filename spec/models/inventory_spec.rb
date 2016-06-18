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

	it "can use .size to get total quantity of all items" do
		inventory = create(:inventory)
		create(:holding, inventory_id: inventory.id, quantity: 10)
		create(:holding, inventory_id: inventory.id, quantity: 10)
		expect(inventory.size).to eq(20)
	end

	it "can scope across all inventories by item_id" do
		item = create(:item)
		inventory = create(:inventory_with_items, item_quantity: 10, item_id: item.id)
		inventory2 = create(:inventory_with_items, item_quantity: 10, item_id: item.id)
		create(:holding, inventory_id: inventory.id, quantity: 10)

		expect(Inventory.item_total(item.id)).to eq(20)
	end

	describe "distribute!" do
	  it "distrbutes items from inventory" do
		  inventory = create :inventory_with_items, item_quantity: 300
		  item = inventory.items.first
		  result = inventory.distribute!(item => 50)
		  expect(result).to be_a Ticket
		  expect(result.containers.first.item).to eq item
		  expect(result.containers.first.quantity).to eq 50 
	  end
  
	  it "does not distribute if insufficient inventory" do
		  inventory = create :inventory_with_items, item_quantity: 300
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

    describe "intake!" do
      let!(:inventory) { create(:inventory) }

      it "adds items to inventory even if none exist" do
      	donation = create(:donation, :with_item, item_quantity: 10)
        expect{
        	inventory.intake!(donation)
            inventory.items.reload
        }.to change{inventory.items.count}.by(1)

      end

      it "adds items to the inventory total if that item already exists in inventory" do
      	inventory = create(:inventory_with_items, item_quantity: 10)
      	donation = create(:donation, :with_item, item_quantity: 10, item_id: inventory.holdings.first.item_id)
		inventory.intake!(donation)
		
		expect(inventory.holdings.count).to eq(1)
		expect(inventory.holdings.where(item_id: donation.containers.first.item.id).first.quantity).to eq(20)

	  end
    end
end

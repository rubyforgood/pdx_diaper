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
end

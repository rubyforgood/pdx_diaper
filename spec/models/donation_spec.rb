# == Schema Information
#
# Table name: donations
#
#  id                  :integer          not null, primary key
#  source              :string
#  receipt_number      :string
#  dropoff_location_id :integer
#  created_at          :datetime
#  updated_at          :datetime
#

require "rails_helper"

RSpec.describe Donation, type: :model do
	let(:d) { FactoryGirl.create :donation }
	it "has a dropoff location" do
		expect(d.dropoff_location).to_not be nil
	end
	it "has a source" do
		expect(d.source).to_not be nil
	end
	pending "has a receipt number" do
		expect(d.receipt_number).to_not be nil
	end
	it "has a completed flag by default" do
		expect(d.completed).to be false
	end

  describe "validations >" do
	  it "doesn't allow location to blank" do
		  expect(build(:donation, dropoff_location: nil)).not_to be_valid
	  end
	  it "doesn't allow source to be nil" do
		  expect(build(:donation, source: nil)).not_to be_valid
	  end
  end

  it "has many items" do
  	item = create :item
  	d.track(item, 3)
  	expect(d.items.count).to eq(1)
  end

  it "has an item total" do
  	item1 = create :item
  	item2 = create :item
  	d.track(item1, 4)
  	d.track(item2, 5)
  	expect(d.total_items).to eq(9)
  end

end

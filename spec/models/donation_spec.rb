# == Schema Information
#
# Table name: donations
#
#  id                  :integer          not null, primary key
#  source              :string(255)
#  receipt_number      :string(255)
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
	it "has a receipt number" do
		expect(d.receipt_number).to_not be nil
	end
  describe "validations >" do
	  it "doesn't allow location to blank" do
		  expect(build(:donation, dropoff_location: nil)).not_to be_valid
	  end
	  it "doesn't allow source to be nil" do
		  expect(build(:donation, source: nil)).not_to be_valid
	  end
  end
end

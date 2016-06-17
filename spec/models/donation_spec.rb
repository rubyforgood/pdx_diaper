# == Schema Information
#
# Table name: donations
#
#  id               :integer          not null, primary key
#  dropoff_location :string(255)
#  source           :string(255)
#  receipt_number   :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#

require "rails_helper"

RSpec.describe Donation, type: :model do
	it "has a dropoff location" do
		donation = Donation.create(dropoff_location: "Phoenix", source: "Purchase")
		expect(donation.dropoff_location).to_not be nil
	end
	it "has a created date" do
		donation = Donation.create(dropoff_location: "Phoenix", source: "Purchase")
		expect(donation.created_at).to_not be nil
	end
	it "has a source" do
		donation = Donation.create(dropoff_location: "Phoenix", source: "Purchase")
		expect(donation.source).to_not be nil
	end
	it "has a receipt number" do
		donation = Donation.create(dropoff_location: "Phoenix", receipt_number: "ABCDEFG", source: "Purchase")
		expect(donation.receipt_number).to_not be nil
	end

	it "doesn't allow location to blank" do
		expect(Donation.create(source: "Purchase", source: nil).valid?).to be false
	end
	it "doesn't allow source to be nil" do
		expect(Donation.create(dropoff_location: "Phoenix", source: nil).valid?).to be false
	end
end

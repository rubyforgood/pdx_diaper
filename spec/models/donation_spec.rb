# == Schema Information
#
# Table name: donations
#
#  id               :integer          not null, primary key
#  dropoff_location :string(255)
#  source           :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#

require "rails_helper"

RSpec.describe Donation, type: :model do
	it "has a dropoff location" do
		donation = Donation.create(dropoff_location: "Phoenix")
		expect(donation.dropoff_location).to_not be nil
	end
	it "has a created date" do
		donation = Donation.create
		expect(donation.created_at).to_not be nil
	end
	it "has a source" do
		donation = Donation.create(source: "Purchase")
		expect(donation.source).to_not be nil
	end 
end

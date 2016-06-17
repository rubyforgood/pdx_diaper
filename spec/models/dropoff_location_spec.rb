require "rails_helper"

RSpec.describe DropoffLocation, type: :model do
	let(:dropoff_location) { FactoryGirl.create :dropoff_location }
	it "has a name" do
		expect(dropoff_location.name).to_not be nil
	end

	it "has an address" do
		expect(dropoff_location.name).to_not be nil
	end

	it "creates a donation" do
		expect{ dropoff_location.receive_donation({source: "Purchase"}) }.to change { Donation.count }.by(1)
	end
	it "has an array of Donation" do
		expect(dropoff_location.donations).to eq([])
	end
end
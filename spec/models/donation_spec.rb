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
	let(:d) { FactoryGirl.create :donation }
	it "has a dropoff location" do
		expect(d.dropoff_location).to_not be nil
	end
	it "has a created date" do
		expect(d.created_at).to_not be nil
	end
	it "has a source" do
		expect(d.source).to_not be nil
	end
	it "has a receipt number" do
		expect(d.receipt_number).to_not be nil
	end

	it "doesn't allow location to blank" do
		expect(Donation.create(source: "Purchase", source: nil).valid?).to be false
	end
	it "doesn't allow source to be nil" do
		expect{FactoryGirl.create(:donation, source: nil)}.to raise_error
	end
end

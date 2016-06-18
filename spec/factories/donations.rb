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

FactoryGirl.define do
	factory :donation do
		dropoff_location
		source "Donation"
		receipt_number "ABCDEF"
	end
end

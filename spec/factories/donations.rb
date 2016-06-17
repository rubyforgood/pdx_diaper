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

FactoryGirl.define do
	factory :donation do
		dropoff_location "Tidy Didy"
		source "Donation"
	end
end

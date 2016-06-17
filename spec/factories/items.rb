# == Schema Information
#
# Table name: items
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  category   :string(255)
#  size       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

FactoryGirl.define do
	factory :item do
		name "3T Diapers"
		category "disposable"
		size "3T"
	end
end

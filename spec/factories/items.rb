# == Schema Information
#
# Table name: items
#
#  id            :integer          not null, primary key
#  name          :string
#  created_at    :datetime
#  updated_at    :datetime
#  category      :string
#  barcode_count :integer
#

FactoryGirl.define do
	factory :item do
		name "3T Diapers"
		category "disposable"
	end
end

# == Schema Information
#
# Table name: dropoff_locations
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  address    :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class DropoffLocation < ActiveRecord::Base

	has_many :donations

	def receive_donation(donation_params)
		donations.create(donation_params)
	end
end

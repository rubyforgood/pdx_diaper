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

class Donation < ActiveRecord::Base

	belongs_to :dropoff_location

	validates :dropoff_location, presence: true
	validates :source, presence: true
end

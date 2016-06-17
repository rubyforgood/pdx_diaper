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

class Donation < ActiveRecord::Base

	belongs_to :dropoff_location

	validates :dropoff_location, presence: true
	validates :source, presence: true
end

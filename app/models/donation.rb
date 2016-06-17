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

class Donation < ActiveRecord::Base
end

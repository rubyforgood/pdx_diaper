# == Schema Information
#
# Table name: holdings
#
#  id         :integer          not null, primary key
#  quantity   :integer
#  created_at :datetime
#  updated_at :datetime
#

class Holding < ActiveRecord::Base
end

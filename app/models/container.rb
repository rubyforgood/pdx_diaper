class Container < ActiveRecord::Base

	validates :quantity, presence: true
end

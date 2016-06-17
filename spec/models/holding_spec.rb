# == Schema Information
#
# Table name: holdings
#
#  id         :integer          not null, primary key
#  quantity   :integer
#  created_at :datetime
#  updated_at :datetime
#

require "rails_helper"

RSpec.describe Holding, type: :model do
	it "has a quantity" do
		holding = FactoryGirl.create :holding
		expect(holding.quantity).to_not be nil
	end
  it "is an integer" do
		holding = FactoryGirl.create :holding
    expect(holding.quantity).to be_a(Integer)
  end
  it "is not a negative number" do
		holding = FactoryGirl.create :holding
    expect(holding.quantity). to be >= 0
  end
end

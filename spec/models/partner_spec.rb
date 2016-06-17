# == Schema Information
#
# Table name: partners
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require "rails_helper"

RSpec.describe Partner, type: :model do
  it "has a name" do
    partner = FactoryGirl.create :partner
    expect(partner.name).to_not be nil
  end

  it "has an email address" do
    partner = FactoryGirl.create :partner
    expect(partner.email).to_not be nil
  end

end

# == Schema Information
#
# Table name: tickets
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#

require "rails_helper"

RSpec.describe Ticket, type: :model do
  it "has one partner" do
    assc = described_class.reflect_on_association(:partner)
    expect(assc.macro).to eq :has_one
  end

  it "has many items through container" do
    assc = described_class.reflect_on_association(:item)
    expect(assc.macro).to eq :has_many
  end
end

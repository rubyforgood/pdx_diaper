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
  it "is invalid if it tries to issue more product than what is on-hand" do
  	create(:ticket_with_items)
  end
end

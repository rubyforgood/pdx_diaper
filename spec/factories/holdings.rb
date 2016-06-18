# == Schema Information
#
# Table name: holdings
#
#  id         :integer          not null, primary key
#  quantity   :integer
#  created_at :datetime
#  updated_at :datetime
#

FactoryGirl.define do
  factory :holding do
    quantity 300
    item
  end
end

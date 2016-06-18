# == Schema Information
#
# Table name: inventories
#
#  id         :integer          not null, primary key
#  name       :string
#  address    :string
#  created_at :datetime
#  updated_at :datetime
#

FactoryGirl.define do
  factory :inventory do
    name "Smithsonian Institute"
    address "1500 Remount Road, Front Royal, VA"
  end
end

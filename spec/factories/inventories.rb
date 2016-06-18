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
    factory :inventory_with_items do
      after(:create) do |inventory, evaluator|
        create_list(:holding, 1, inventory: inventory)
      end
    end
  end
end

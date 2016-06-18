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

    transient do
    	item_quantity 1
    	item_id nil
    end

    factory :inventory_with_items do
      after(:create) do |inventory, evaluator|
      	item_id = (evaluator.item_id.nil?) ? create(:item).id : evaluator.item_id
        create_list(:holding, 1, inventory: inventory, quantity: evaluator.item_quantity, item_id: item_id)
      end
    end
  end
end

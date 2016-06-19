# == Schema Information
#
# Table name: tickets
#
#  id           :integer          not null, primary key
#  created_at   :datetime
#  updated_at   :datetime
#  partner_id   :integer
#  inventory_id :integer
#

FactoryGirl.define do

  factory :ticket do
    inventory
    partner

    transient do
    	item_quantity 10
    	item_id nil
    end

    factory :ticket_with_items do
      after(:create) do |ticket, evaluator|
      	item_id = (evaluator.item_id.nil?) ? create(:item).id : evaluator.item_id
        create_list(:container, 1, itemizable: ticket, quantity: evaluator.item_quantity, item_id: item_id)
      end
    end
  end
end

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

FactoryGirl.define do
  factory :partner do
    name "Leslie Sue"
    email "leslie@gmail.com"
  end
end

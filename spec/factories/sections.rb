require 'faker'
FactoryGirl.define do
  
  factory :section do
    location { Faker::Number.number(3) }
    company
    mall
    contact
  end
  
end
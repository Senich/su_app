require 'faker'
FactoryGirl.define do
  
  factory :section do
    name { Faker::Number.number(3) }
    contact
  end
  
end
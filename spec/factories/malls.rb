require 'faker'
FactoryGirl.define do
  factory :mall do
    name { Faker::Company.name }
    city { Faker::Address.city }
    street { Faker::Address.street_name }
    building { Faker::Address.building_number }
    details { Faker::Company.catch_phrase }
    contact
  end
end
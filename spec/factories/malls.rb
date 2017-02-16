require 'faker'
FactoryGirl.define do
  factory :mall do
    name { Faker::Company.name }
    city { Faker::Address.city }
    street { Faker::Address.street_name }
    building { Faker::Address.building_number }
    about { Faker::Company.catch_phrase }
    contact

    
    factory :mall_with_companies do
      
      transient do
        companies_count 1
      end
      
      #т.к. компании с моллами связаны через секции, то создаём для моллов секции, а они автоматом генерят компании
      after(:create) do |mall, evaluator|
        create_list(:section, evaluator.companies_count, mall: mall)
      end
      
    end
    
  end
end
require 'faker'
FactoryGirl.define do
  
  factory :company do
    name Faker::Company.name
    
    factory :company_with_address do
      
      transient do
        address_count 1
      end
      
      after(:create) do |company, evaluator|
        create_list(:address, evaluator.address_count, companies: [company])
      end
      
    end
    
  end
  
end
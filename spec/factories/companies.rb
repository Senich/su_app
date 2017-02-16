require 'faker'
FactoryGirl.define do
  
  factory :company do
    name { Faker::Company.name }
    about { Faker::Company.catch_phrase }
    contact
    
    factory :company_at_few_malls do
      
      transient do
        malls_count 1
      end
      
      after(:create) do |company, evaluator|
        create_list(:mall, evaluator.malls_count, companies: [company])
      end
      
    end
    
    trait :with_section do
      transient do
        sections_count 1
      end
      
      after(:create) do |company, evaluator|
        create_list(:section, evaluator.sections_count, company: company)
      end
    end
  end
  
end
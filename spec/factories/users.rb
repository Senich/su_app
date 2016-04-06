FactoryGirl.define do
  factory :user do
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    email { Faker::Internet.email }
    password 'password'

    trait :admin do
      role 'admin'
    end

    trait :seller do
      role 'seller'
    end

    trait :user do
      role 'user'
    end
    
    factory :user_with_products do
      transient do 
        product_count  1
      end
      
      after(:create) do |user, evaluator|
        create_list(:product, evaluator.product_count, user: user)
      end
      
    end

  end
end
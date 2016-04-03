FactoryGirl.define do
  factory :user do
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    email 'john@doe.com'
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

  end
end
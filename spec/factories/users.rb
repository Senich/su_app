require 'faker'
FactoryGirl.define do
  factory :user do
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    email { Faker::Internet.email }
    password 'password'


    trait :admin do
      role 'admin'
      first_name 'Simon'
    end

    trait :seller do
      role 'seller'
      company
    end

    trait :user do
      role 'user'
    end

  end
end
require 'faker'
FactoryGirl.define do
  factory :contact do
    email { Faker::Internet.email }
    details { Faker::Lorem.sentence }

      transient do
        phones_count 1
      end

      after(:create) do |contact, evaluator|
        create_list(:phone_mall, evaluator.phones_count, contact: contact)
      end
   
  end
end
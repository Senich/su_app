require 'faker'
FactoryGirl.define do

  factory :phone do
    number Faker::Number.number(7)
    extension Faker::PhoneNumber.extension
    notes Faker::Lorem.sentence

    factory :phone_long do
      number Faker::Number.number(11)
    end

    factory :phone_section do
      section
    end

  end

end

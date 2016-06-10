require 'faker'
FactoryGirl.define do
  factory :product do
    name 'Chair'
    color { Faker::Color.color_name }
    width 100
    height 150
    depth 200
    category 'Мебель для гостинной'
    price { Faker::Commerce.price }
    description Faker::Lorem.sentence
    company

    factory :product_with_attachments do

      transient do
        attachments_count 1
      end

      after(:create) do |product, evaluator|
        create_list(:product_attachment, evaluator.attachments_count, product: product )
      end

    end

  end
end
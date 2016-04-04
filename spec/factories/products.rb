FactoryGirl.define do
  factory :product do
    name 'Chair'
    color Faker::Color.color_name
    width 100
    height 150
    depth 200
    category 'Мебель для гостинной'
    description Faker::Lorem.sentence
    user
  end
end
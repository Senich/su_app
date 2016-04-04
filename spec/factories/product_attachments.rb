FactoryGirl.define do
  factory :product_attachment do
    picture 'picture.jpg'
    association :product
  end

end
FactoryGirl.define do
  factory :product do
    name { Faker::Commerce.product_name }
    description { Faker::Company.bs }
    remote_image_url { Faker::Avatar.image }
    price { Faker::Commerce.price }
    inventory
  end
end

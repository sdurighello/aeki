FactoryGirl.define do
  factory :inventory do
    quantity { Faker::Number.between(4, 10) }
  end
end

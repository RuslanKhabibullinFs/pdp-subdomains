FactoryGirl.define do
  factory :rating do
    user
    post
    rating { rand(1..5) }
  end
end

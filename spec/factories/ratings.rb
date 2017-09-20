FactoryGirl.define do
  factory :rating do
    user
    post
    score { rand(1..5) }
  end
end

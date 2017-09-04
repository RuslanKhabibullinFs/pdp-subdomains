FactoryGirl.define do
  factory :user, aliases: %i[owner] do
    email
    first_name
    last_name
    password "123456"
    password_confirmation "123456"

    trait :with_posts do
      transient do
        number_of_posts 1
      end

      after :create do |user, evaluator|
        FactoryGirl.create_list :post, evaluator.number_of_posts, user: user
      end
    end
  end
end

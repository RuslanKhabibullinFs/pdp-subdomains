FactoryGirl.define do
  factory :user, aliases: %i[owner] do
    email
    first_name
    last_name
    password "123456"
    password_confirmation "123456"
  end
end

FactoryGirl.define do
  sequence(:email) { Faker::Internet.unique.email }
  sequence(:first_name) { Faker::Name.first_name }
  sequence(:last_name) { Faker::Name.last_name }
  sequence(:company_name) { Faker::Company.unique.name }
  sequence(:company_subdomain) { Faker::Internet.unique.domain_word }
  sequence(:post_title) { Faker::Lorem.sentence }
  sequence(:post_content) { Faker::Lorem.sentence }
end

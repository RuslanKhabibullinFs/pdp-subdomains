FactoryGirl.define do
  sequence(:email) { Faker::Internet.email }
  sequence(:first_name) { Faker::Name.first_name }
  sequence(:last_name) { Faker::Name.last_name }
  sequence(:company_name) { Faker::Company.name }
  sequence(:company_subdomain) { Faker::Internet.domain_word }
end

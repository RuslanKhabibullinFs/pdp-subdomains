FactoryGirl.define do
  factory :company_registration_form do
    email
    first_name
    last_name
    password "123456"
    password_confirmation "123456"
    company_name
    company_subdomain
  end
end

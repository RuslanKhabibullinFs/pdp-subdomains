FactoryGirl.define do
  factory :company do
    owner
    name { generate(:company_name) }
    subdomain { generate(:company_subdomain) }
  end
end

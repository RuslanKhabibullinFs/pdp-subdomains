FactoryGirl.define do
  factory :post do
    company
    user
    title { generate(:post_title) }
    content { generate(:post_content) }
  end
end

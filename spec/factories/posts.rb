FactoryGirl.define do
  factory :post do
    title { generate(:post_title) }
    content { generate(:post_content) }
  end
end

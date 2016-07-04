FactoryGirl.define do
  factory :feed do
    sequence(:title) { |n| "Title" }
    sequence(:url) { |n| "mail#{n}@example.com" }
  end
end

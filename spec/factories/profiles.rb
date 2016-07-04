FactoryGirl.define do
  factory :profile do
    user

    sequence(:first_name) { |n| "FirstName#{n}" }
    sequence(:last_name) { |n| "LastName#{n}" }
    sequence(:nickname) { |n| "Nickname#{n}" }
  end
end

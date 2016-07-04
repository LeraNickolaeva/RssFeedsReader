FactoryGirl.define do
  factory :oauth_account do
    user

    sequence(:uid) { |n| n.to_s }
    provider 'twitter'
  end
end

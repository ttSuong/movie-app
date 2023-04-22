FactoryBot.define do
  factory :user do
    id { |number| number }
    sequence(:email) { |n| "abc#{n}@example.com" }
    password { '123456' }
  end

  factory :api_key do
    token "SomeRandomToken"
  end
end
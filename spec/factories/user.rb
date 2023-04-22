FactoryBot.define do
  factory :user do
    id { |number| number }
    email { 'test1@gmail.com'}
    password { '123456' }
  end

  factory :api_key do
    token "SomeRandomToken"
  end
end
FactoryBot.define do
  factory :user do
    skip_create
    email { 'test1@gmail.com'}
    password { '123456' }
  end
end
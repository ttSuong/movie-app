FactoryBot.define do
  factory :access_token, class: "Doorkeeper::AccessToken" do
    application
    expires_in { 2.hours }
    scopes { "public" }
  end

  factory :application, class: "Doorkeeper::Application" do
    sequence(:name) { 'Rspec' }
    sequence(:redirect_uri)  {  }
  end
end
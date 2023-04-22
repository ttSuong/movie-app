require 'rails_helper'
RSpec.describe "Login", type: :request do
  context 'When a REST client sends a request for getting the grant' do
    before(:all) do
      @user = create(:user, :email => 'login122@gmail.com')
    end
    it "Login successfully if user have been done registration" do
      app = Doorkeeper::Application.create(name: "rspec", redirect_uri: "", scopes: "")
      params_login = {
        email: @user.email,
        password: '123456',
        client_id: app.uid
      }
      post "/api/login", params: params_login
      body_login = JSON.parse(response.body)
      expect(body_login['result'].present?).to eq(true)
    end

    it "Login successfully if user have not been done registration" do
      app = Doorkeeper::Application.create(name: "rspec", redirect_uri: "", scopes: "")
      params_login = {
        email: 'new@gmail.com',
        password: '123456',
        client_id: app.uid
      }
      post "/api/login", params: params_login
      body_login = JSON.parse(response.body)
      expect(body_login['result'].present?).to eq(true)
    end
  end
end
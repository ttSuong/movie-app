Doorkeeper.configure do
  orm :active_record
  access_token_expires_in 24.hours
  resource_owner_from_credentials do |_routes|
    User.authenticate(params[:email], params[:password])
  end

  grant_flows %w[password]
  allow_blank_redirect_uri true
  skip_authorization do
    true
  end

  use_refresh_token
end

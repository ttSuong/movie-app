class Api::GenerateTokenService
  attr_reader :user

  def initialize(user, client_id)
    @user = user
    @client_id = client_id
  end

  def call
    generate_token user
  end

  private

  def generate_refresh_token
    loop do
      token = SecureRandom.hex(32)
      break token unless Doorkeeper::AccessToken.exists?(refresh_token: token)
    end
  end
  def generate_token user
    access_token = Doorkeeper::AccessToken.create(
      resource_owner_id: user.id,
      application_id: @client_id,
      refresh_token: generate_refresh_token,
      expires_in: Doorkeeper.configuration.access_token_expires_in.to_i,
      scopes: ''
    )

    token_info = Doorkeeper::OAuth::TokenResponse.new(access_token).body
                                                 .merge uid: user.id, email: user.email
    created_at = token_info["created_at"]
    token_info["created_at"] = Time.zone.at(created_at).iso8601
    token_info.merge expires_on: Time.zone.at(created_at + token_info["expires_in"]).iso8601
  end
end

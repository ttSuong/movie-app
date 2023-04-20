module Api::Users
  class Register
    prepend SimpleCommand
    def initialize(params)
      @user_params = params
    end

    def call
      raise I18n.t("user.errors.#{invalid_client}") unless client_app
      user = User.new(email: user_params[:email], password: user_params[:password])
      result = user.save
      raise I18n.t("user.errors.#{error_register}") unless result
      response(user, access_token)
    end

    private
    def client_app
      @client_app ||= Doorkeeper::Application.find_by(uid: params[:client_id])
    end

    def generate_refresh_token
      loop do
        token = SecureRandom.hex(32)
        break token unless Doorkeeper::AccessToken.exists?(refresh_token: token)
      end
    end

    def access_token
      Doorkeeper::AccessToken.create(
        resource_owner_id: user.id,
        application_id: client_app.id,
        refresh_token: generate_refresh_token,
        expires_in: Doorkeeper.configuration.access_token_expires_in.to_i,
        scopes: ''
      )
    end

    def response(user, access_token)
      {
        id: user.id,
        email: user.email,
        access_token: access_token.token,
        token_type: 'bearer',
        expires_in: access_token.expires_in,
        refresh_token: access_token.refresh_token,
        created_at: access_token.created_at.to_time.to_i
      }
    end
  end
end
module Users
  class Register
    prepend SimpleCommand
    def initialize(params, client_id)
      @user_params = params
      @client_id = client_id
    end

    def call
      create_user
    end

    private

    def create_user
      exist_user = User.find_by(email: @user_params[:email])
      raise I18n.t("user.errors.exist_profile") if exist_user.present?
      user = User.create(email: @user_params[:email], password: @user_params[:password])
      raise I18n.t("user.errors.error_register") unless user
      access_token = Api::GenerateTokenService(user, @client_id)
      response(user, access_token)
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
module Users
  class CreateSession
    prepend SimpleCommand
    def initialize(params, client_id)
      @user_params = params
      @client_id = client_id
    end

    def call
      user = User.find_by(email: @user_params[:email])
      if user.present?
        session = User.authenticate(@user_params[:email], @user_params[:password])
        raise I18n.t("user.errors.invalid_password") unless session.present?
      else
        user = User.create(email: @user_params[:email], password: @user_params[:password])
        raise I18n.t("user.errors.error_register") unless user.present?
      end
      Api::GenerateTokenService.new(user, @client_id).call
    end
  end
end
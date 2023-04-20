class Api::SessionController < Api::ApplicationController
  def create
    return  render(json: { error: I18n.t("user.errors.invalid_client") }, status: 422) unless client_app.present?
    user = User.authenticate(user_params[:email], user_params[:password])
    if user
      render json: { data: Api::GenerateTokenService.new(user, client_app.id).call }, status: 200
    else
      render json: {errors: I18n.t("errors.api.sessions_controller.login.failed")}, status: 400
    end
  end

  def destroy
    revoke_token_service = Api::RevokeTokenService.new doorkeeper_token.token
    revoke_token_service.execute
    if revoke_token_service.success?
      render json: {}, status: 200
    else
      render json: {errors: revoke_token_service.errors}, status: 400
    end
  end

  private
  def user_params
    params.permit(:email, :password)
  end

  def client_app
    @client_app ||= Doorkeeper::Application.find_by(uid: params[:client_id])
  end
end

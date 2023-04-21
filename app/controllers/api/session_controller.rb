class Api::SessionController < Api::ApplicationController
  skip_before_action :doorkeeper_authorize!, only: %i[create]
  def create
    return render json: { error: I18n.t("user.errors.invalid_client") }, status: 422 unless client_app.present?
    command = Users::CreateSession.call(user_params, client_app.id)
    render json: { result: command.result }
  rescue => ex
    render json: { errors: ex.message }, status: 500
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

  def user
    @user ||= User.find_by(email: user_params[:email])
  end
end

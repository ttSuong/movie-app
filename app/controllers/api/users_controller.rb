class Api::UsersController < Api::ApplicationController
  skip_before_action :doorkeeper_authorize!, only: %i[create]

  def create
    return  render(json: { error: I18n.t("user.errors.invalid_client") }, status: 422) unless client_app.present?
    command = Users::Register.call(user_params, client_app.id)
    return render(json: { error: command.errors[:message] }, status: 422) unless command.success?
    render(json: { result: command.result }, status: 200)
  rescue => ex
    render(json: { error: ex.message }, status: 422)
  end

  def show
    @user = User.find_by(email: user_params[:email])
    return render(json: { result:  @user }, status: 200) if @user.present?
    render(json: { error: I18n.t("user.errors.not_exist_profile") }, status: 422)
  end

  private

  def client_app
    @client_app ||= Doorkeeper::Application.find_by(uid: params[:client_id])
  end
  def user_params
    params.permit(:email, :password)
  end
end
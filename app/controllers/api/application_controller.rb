class Api::ApplicationController < ActionController::API
  before_action :doorkeeper_authorize!

  private
  def current_user
    Rails.logger.warn("===== #{doorkeeper_token.inspect} ========")
    @current_user ||= User.find_by(id: doorkeeper_token[:resource_owner_id]) if doorkeeper_token.present?
  end
end

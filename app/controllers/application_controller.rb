class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods

  # Instead of :authenticate_user!.
  # We need http basic auth.
  before_action :authenticate_user_by_http_basic_auth

  # use only json
  respond_to :json

  private

  def authenticate_user_by_http_basic_auth
    authenticate_or_request_with_http_basic do |email, password|
      resource = User.find_by_email(email)
      next unless resource.try(:valid_password?, password)

      sign_in :user, resource
    end
  end
end

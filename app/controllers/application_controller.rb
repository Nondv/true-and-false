class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods

  private

  def authenticate_user_by_http_basic_auth!
    authenticate_or_request_with_http_basic do |email, password|
      resource = User.find_by_email(email)
      next unless resource.try(:valid_password?, password)

      sign_in :user, resource
    end
  end
end

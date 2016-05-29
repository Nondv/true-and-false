class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :render_403

  private

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  def render_403
    render json: { message: 'Forbidden' }, status: 403
  end

  def authenticate_user_by_http_basic_auth!
    authenticate_or_request_with_http_basic do |email, password|
      resource = User.find_by_email(email)
      next unless resource.try(:valid_password?, password)

      sign_in :user, resource
      @current_user = resource
    end
  end

  def current_user
    @current_user
  end
end

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  #
  # Creates hash with HTTP Basic Auth token
  #
  def headers_for_http_auth(user, password)
    { 'HTTP_AUTHORIZATION' => http_basic_auth_token(user, password) }
  end

  def http_basic_auth_token(user, password)
    ActionController::HttpAuthentication::Basic.encode_credentials(user, password)
  end
end

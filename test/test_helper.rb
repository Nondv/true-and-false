ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def json_response
    JSON.parse(response.body)
  end

  def get_as(user, path, params = {})
    make_request_with_auth(:get, user, path, params)
  end

  def patch_as(user, path, params = {})
    make_request_with_auth(:patch, user, path, params)
  end

  def post_as(user, path, params = {})
    make_request_with_auth(:post, user, path, params)
  end

  def delete_as(user, path, params = {})
    make_request_with_auth(:delete, user, path, params)
  end

  # Makes request with HTTP Basic Auth headers
  def make_request_with_auth(request, user, path, params = {})
    params[:headers] ||= {}
    params[:headers] = params[:headers].merge(headers_for_http_auth(user.email, '0000'))

    method(request).call path, params
  end

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

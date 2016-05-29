class UsersController < ApplicationController
  before_action :authenticate_user_by_http_basic_auth!

  def index
  end
end

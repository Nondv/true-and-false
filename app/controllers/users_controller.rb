class UsersController < ApplicationController
  before_action :authenticate_user_by_http_basic_auth!

  def index
  end

  def show_current_user
    render json: current_user,
           only: [:id, :email],
           callback: params[:callback]
  end
end

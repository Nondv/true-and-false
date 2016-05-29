class UsersController < ApplicationController
  before_action :authenticate_user_by_http_basic_auth!

  def index
    authorize User

    render json: policy_scope(User),
           callback: params[:callback]
  end

  def show
    @user = User.find(params[:id])
    authorize @user

    render json: @user,
           callback: params[:callback]
  end

  def show_current_user
    render json: current_user,
           only: [:id, :email],
           callback: params[:callback]
  end
end

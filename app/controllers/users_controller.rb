class UsersController < ApplicationController
  before_action :authenticate_user_by_http_basic_auth!
  before_action :set_user, only: [:show, :update, :destroy]

  def index
    authorize User

    render json: policy_scope(User),
           callback: params[:callback]
  end

  def show
    render json: @user,
           callback: params[:callback]
  end

  def show_current_user
    render json: current_user,
           only: [:id, :email],
           callback: params[:callback]
  end

  def update
    if @user.update_attributes(permitted_attributes(@user))
      render json: @user, callback: params[:callback]
    else
      render json: @user.errors, status: :unprocessable_entity, callback: params[:callback]
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
    authorize @user
  end
end

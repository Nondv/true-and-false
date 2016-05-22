class AttemptsController < ApplicationController
  before_action :authenticate_user_by_http_basic_auth!
  before_action :set_attempt, only: [:show, :update, :destroy]

  # GET /attempts
  def index
    @attempts = policy_scope(Attempt)
    render json: @attempts
  end

  # GET /attempts/1
  def show
    render json: @attempt, include: [:user, :statement]
  end

  # POST /attempts
  def create
    statement = Statement.find(params[:statement_id])
    @attempt = Attempt.new user: current_user,
                           statement: statement,
                           success: answer == statement.value

    authorize @attempt

    if @attempt.save
      data = { user_email: @attempt.user.email,
               statement_id: @attempt.statement.id,
               success: @attempt.success }
      render json: data, status: :created, location: @attempt
    else
      render json: @attempt.errors, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render nothing: true, status: 400 # bad request
  end

  # PATCH/PUT /attempts/1
  def update
    if @attempt.update(attempt_params)
      render json: @attempt
    else
      render json: @attempt.errors, status: :unprocessable_entity
    end
  end

  # DELETE /attempts/1
  def destroy
    @attempt.destroy
  end

  private

  def answer
    case params[:answer].downcase
    when 'true' then true
    when 'false' then false
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_attempt
    @attempt = Attempt.find(params[:id])
    authorize @attempt
  end

  # Only allow a trusted parameter "white list" through.
  def attempt_params
    white_list = [:success, :user_id, :statement_id]
    params.require(:attempt).permit(*white_list)
  end
end

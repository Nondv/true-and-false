class StatementsController < ApplicationController
  # Instead of :authenticate_user!.
  # We need http basic auth.
  before_action :authenticate_user_by_http_basic_auth!
  before_action :set_statement, only: [:show, :update, :destroy]

  # GET /statements
  def random
    offset = rand(Statement.count)
    @statement = Statement
                 .select(:id, :ru)
                 .offset(offset)
                 .first

    authorize @statement
    render json: @statement
  end

  alias index random

  # GET /statements/1
  def show
    render json: @statement
  end

  # POST /statements
  def create
    @statement = Statement.new(statement_params)
    authorize @statement

    if @statement.save
      render json: @statement, status: :created, location: @statement
    else
      render json: @statement.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /statements/1
  def update
    if @statement.update(statement_params)
      render json: @statement
    else
      render json: @statement.errors, status: :unprocessable_entity
    end
  end

  # DELETE /statements/1
  def destroy
    @statement.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_statement
      @statement = Statement.find(params[:id])
      authorize @statement
    end

    # Only allow a trusted parameter "white list" through.
    def statement_params
      white_list = [:ru, :ru_explanation, :points, :value]
      params.require(:statement).permit(*white_list)
    end
end

class GameController < ApplicationController
  before_action :authenticate_user_by_http_basic_auth!

  # GET /
  def random_gamecard
    offset = rand(Statement.count)
    statement = Statement
                .select(:id, :ru)
                .offset(offset)
                .first

    attempt = Attempt.create!(statement: statement, user: current_user)

    render json: attempt.game_card,
           callback: params[:callback]
  end

  # POST /answer/1
  def make_a_guess
    attempt = policy_scope(Attempt).find_by_id(params[:id])
    not_found unless attempt

    answer = case params.require(:answer).downcase
             when 'true' then true
             when 'false' then false
             end

    if answer.nil? || attempt.performed? || attempt.user_id != current_user.id
      render_403
    else
      statement = attempt.statement
      attempt.success = (statement.value == answer)
      attempt.save

      response_data = { success: attempt.success,
                        explanation: statement.ru_explanation }

      render json: response_data
    end
  end
end

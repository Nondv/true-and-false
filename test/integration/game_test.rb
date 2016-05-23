require 'test_helper'

class GameTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:plain_user)
  end

  test 'need to be authorized' do
    get '/'
    assert_response 401

    get_as(@user, '/')
    assert_response :success
  end

  test 'game process' do
    get_as(@user, '/')
    game_card = json_response.symbolize_keys

    # answer game card
    attempt = Attempt.find(game_card[:id])
    answer = [true, false].sample # random. TODO: random in tests is bad, so just use separate tests
    post_as @user,
            "/answer/#{attempt.id}",
            params: { answer: answer }

    assert_response :success

    expected_data = { explanation: attempt.statement.ru_explanation,
                      success: (answer == attempt.statement.value) }

    data = json_response.symbolize_keys
    assert_equal(expected_data, data)
  end
end


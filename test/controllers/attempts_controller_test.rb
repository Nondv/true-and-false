require 'test_helper'

class AttemptsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @attempt = attempts(1)
    @user = users(:plain_user)
    @admin = users(:admin)
    @statement = statements(:one)
  end

  test 'should force auth' do
    get(attempts_url)
    assert_response 401

    post attempts_url
    assert_response 401

    patch attempt_url(@attempt)
    assert_response 401

    delete attempt_url(@attempt)
    assert_response 401
  end

  test 'should get index with user credentials' do
    get_as(@user, attempts_url)
    assert_response :success
  end

  test 'should get only my attempts unless I am admin' do
    get_as(@user, attempts_url)
    # check if all records belong to @user
    data = json_response
    user_ids = data.map { |e| e['user_id'] }.uniq
    assert_equal(3, data.size)
    assert_equal(1, user_ids.size)
    assert_equal(@user.id, user_ids.first)

    get_as(@admin, attempts_url)
    data = json_response
    assert_equal(5, data.size)
    assert_equal(2, data.map { |e| e['user_id'] }.uniq.size)
  end

  test 'should create attempt' do
    params = { statement_id: @statement.id,
               answer: true }

    assert_difference('Attempt.count') do
      post_as(@user, attempts_url, params: params)
      assert_response 201
    end

    data = json_response.symbolize_keys
    expected_data = { user_email: @user.email,
                      statement_id: @statement.id,
                      success: (@statement.value == params[:answer]) }
    assert_equal(expected_data, data)
  end

  test 'should  show attempt if I am admin' do
    get_as(@user, attempt_url(@attempt))
    assert_response 403

    get_as(@admin, attempt_url(@attempt))
    assert_response :success

    expected_data = @attempt.as_json(include: [:user, :statement]).to_json
    data = response.body
    assert_equal(expected_data, data)
  end

  test 'should update attempt if I am admin' do
    params = { attempt: { success: !@attempt.success } }

    patch_as(@user, attempt_url(@attempt), params: params)
    assert_response 403

    patch_as(@admin, attempt_url(@attempt), params: params)
    @attempt.reload
    assert_equal(params[:attempt][:success], @attempt.success)
  end

  test 'should destroy attempt if I am admin' do
    delete_as(@user, attempt_url(@attempt))
    assert_response 403

    assert_difference('Attempt.count', -1) do
      delete_as(@admin, attempt_url(@attempt))
    end

    assert_response 204
    assert_equal(nil, Attempt.find_by_id(@attempt.id))
  end
end

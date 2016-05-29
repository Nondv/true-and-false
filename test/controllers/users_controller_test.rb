require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:admin)
    @user = users(:plain_user)
  end

  test 'should force auth' do
    get users_url
    assert_response 401
  end

  test 'should show me' do
    [@admin, @user].each do |u|
      get_as u, users_me_url
      assert_response :success
      assert_equal(json_response, u.as_json(only: [:id, :email]))
    end
  end

  test 'should show users if I am admin' do
    get_as @user, user_url(@user)
    assert_response :forbidden

    get_as @admin, user_url(@user)
    assert_response :success
  end

  test 'should get index if I am admin' do
    get_as @user, users_url
    assert_response :forbidden

    get_as @admin, users_url
    assert_response :success
  end

  test 'should update users if I am admin' do
    new_email = "updated_#{@user.email}"
    user_params = { user: { email: new_email } }

    patch_as @user,
             user_url(@user),
             params: user_params
    assert_response :forbidden

    patch_as @admin,
             user_url(@user),
             params: user_params
    assert_response 200
    assert_equal(new_email, User.find(@user.id).email)
  end

  test 'should destroy users if I am admin' do
    delete_as @user, user_url(@user)
    assert_response :forbidden

    delete_as @admin, user_url(@user)
    assert_response 204
    assert_nil User.find_by_id(@user.id)
  end

  test 'should create users without auth' do
    assert_difference('User.count') do
      post users_url, params: { user: { email: 'unexisted_user@test-test',
                                        password: '0000' } }
    end

    assert_response 201
  end
end

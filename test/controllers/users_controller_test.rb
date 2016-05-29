require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:admin)
    @user = users(:plain_user)
    @statement = statements(:one)
  end

  test 'should force auth' do
    get users_url
    assert_response 401
  end

  test 'should show me' do
    [@admin, @user].each do |u|
      get_as u, users_me_url
      assert_response :success
      assert_equal(json_response.symbolize_keys, u.as_json)
    end
  end

  test 'should update me' do
    update_as @user,
              users_me_url,
              params: { email: "update_#{@user.email}" }

    assert_response :success
    assert_equal("update_#{@user.email}", User.find(@user.id).email)
  end
end

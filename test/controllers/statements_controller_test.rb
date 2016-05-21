require 'test_helper'

class StatementsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:admin)
    @user = users(:plain_user)
    @statement = statements(:one)
  end

  test 'should force auth' do
    get statements_url
    assert_response 401
  end

  test 'should get index if authorized' do
    get statements_url,
        headers: auth_headers
    assert_response :success
  end

  test 'should show statement if authorized' do
    get statement_url(@statement),
        headers: auth_headers
    assert_response :success
  end

  test 'should not create statement unless authorized as admin' do
    statement_params = { ru: 'test', ru_explanation: 'test', points: 0, value: true }

    # as plain user
    post statements_url,
         params: { statement: statement_params },
         headers: auth_headers(@user)

    assert_response 403

    # as admin
    assert_difference('Statement.count') do
      post statements_url,
           params: { statement: statement_params },
           headers: auth_headers(@admin)
    end

    assert_response 201
  end

  test 'should not update statement unless authorized as admin' do
    attributes = { ru: 'updated ru',
                   ru_explanation: 'updated ru_explanation',
                   points: 2,
                   value: false }

    # try as plain user
    patch statement_url(@statement),
          params: { statement: attributes },
          headers: auth_headers(@user)
    assert_response 403

    # as admin
    patch statement_url(@statement),
          params: { statement: attributes },
          headers: auth_headers(@admin)
    assert_response 200

    record_attributes = Statement
                        .find(@statement.id)
                        .attributes
                        .symbolize_keys
                        .slice(*attributes.keys)

    assert_equal(attributes, record_attributes)
  end

  test 'should not destroy statement unless authorized as admin' do
    url = statement_url(@statement)

    # try as plain user
    delete url,
           headers: auth_headers(@user)
    assert_response 403

    # try as admin
    assert_difference('Statement.count', -1) do
      delete url,
             headers: auth_headers(@admin)
    end

    assert_response 204
  end

  private

  def auth_headers(user = @user)
    headers_for_http_auth(user.email, '0000')
  end
end

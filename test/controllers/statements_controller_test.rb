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
    get_as(@user, statements_url)
    assert_response :success
  end

  test 'should show statement if authorized' do
    get_as(@user, statement_url(@statement))
    assert_response :success
  end

  test 'should not create statement unless authorized as admin' do
    statement_params = { ru: 'test', ru_explanation: 'test', points: 0, value: true }

    # as plain user
    post_as @user,
            statements_url,
            params: { statement: statement_params }

    assert_response 403

    # as admin
    assert_difference('Statement.count') do
      post_as @admin,
              statements_url,
              params: { statement: statement_params }
    end

    assert_response 201
  end

  test 'should not update statement unless authorized as admin' do
    attributes = { ru: 'updated ru',
                   ru_explanation: 'updated ru_explanation',
                   points: 2,
                   value: false }

    # try as plain user
    patch_as @user,
             statement_url(@statement),
             params: { statement: attributes }

    assert_response 403

    # as admin
    patch_as @admin,
             statement_url(@statement),
             params: { statement: attributes }

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
    delete_as(@user, url)
    assert_response 403

    # try as admin
    assert_difference('Statement.count', -1) do
      delete_as(@admin, url)
    end

    assert_response 204
  end
end

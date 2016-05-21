require 'test_helper'

class StatementsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @statement = statements(:one)
  end

  test 'should get index' do
    get statements_url
    assert_response :success
  end

  test 'should create statement' do
    assert_difference('Statement.count') do
      statement_params = { ru: 'test', ru_explanation: 'test', points: 0, value: true }
      post statements_url, params: { statement: statement_params }
    end

    assert_response 201
  end

  test 'should show statement' do
    get statement_url(@statement)
    assert_response :success
  end

  test 'should update statement' do
    attributes = { ru: 'updated ru',
                   ru_explanation: 'updated ru_explanation',
                   points: 2,
                   value: false }

    patch statement_url(@statement), params: { statement: attributes }
    assert_response 200

    record_attributes = Statement
                        .find(@statement.id)
                        .attributes
                        .symbolize_keys
                        .slice(*attributes.keys)

    assert_equal(attributes, record_attributes)
  end

  test 'should destroy statement' do
    assert_difference('Statement.count', -1) do
      delete statement_url(@statement)
    end

    assert_response 204
  end
end

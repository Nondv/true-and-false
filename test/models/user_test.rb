require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:plain_user)
    @statement_one = statements(:one)
    @statement_two = statements(:two)
  end

  test 'table columns' do
    expected_cols = { id: :integer, email: :string, encrypted_password: :string,
                      reset_password_token: :string, reset_password_sent_at: :datetime,
                      remember_created_at: :datetime, sign_in_count: :integer, current_sign_in_at: :datetime,
                      last_sign_in_at: :datetime, current_sign_in_ip: :inet, last_sign_in_ip: :inet,
                      created_at: :datetime, updated_at: :datetime, type: :string }
    table_cols = User.columns_hash.map { |name, col| [name.to_sym, col.type] }.to_h

    assert_equal(expected_cols, table_cols)
  end

  test 'raiting formula' do
    start_up_raiting = 1000
    formula = lambda do |user|
      result = start_up_raiting

      result += user
               .attempts
               .find_all(&:performed?)
               .reduce(0) { |a, e| a + (e.success ? e.statement.points : (- e.statement.points / 2)) }

      result
    end

    brand_new_user = User.create!(email: 'unexisted@user', password: '0000')

    assert_equal(start_up_raiting, brand_new_user.raiting)

    attempts = [{ statement: @statement_one, success: true },
                { statement: @statement_one, success: true },
                { statement: @statement_one, success: false }]

    attempts.each { |a| @user.attempts.create!(a) }

    @user.reload
    assert_equal(formula[@user], @user.raiting)
  end
end

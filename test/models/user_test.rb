require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'table columns' do
    expected_cols = { id: :integer, email: :string, encrypted_password: :string,
                      reset_password_token: :string, reset_password_sent_at: :datetime,
                      remember_created_at: :datetime, sign_in_count: :integer, current_sign_in_at: :datetime,
                      last_sign_in_at: :datetime, current_sign_in_ip: :inet, last_sign_in_ip: :inet,
                      created_at: :datetime, updated_at: :datetime, type: :string }
    table_cols = User.columns_hash.map { |name, col| [name.to_sym, col.type] }.to_h

    assert_equal(expected_cols, table_cols)
  end
end

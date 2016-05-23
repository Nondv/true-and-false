require 'test_helper'

class AttemptTest < ActiveSupport::TestCase
  def test_attributes
    model_attributes = Attempt.columns_hash.map { |name, col| [name.to_sym, col.type.to_sym] }.to_h
    expected_attributes = { id: :integer,
                            user_id: :integer,
                            statement_id: :integer,
                            success: :boolean,

                            created_at: :datetime,
                            updated_at: :datetime }

    assert_equal(expected_attributes, model_attributes)
  end

  test 'fixture amount' do
    expected_amount = 5
    assert_equal(expected_amount, Attempt.count)
  end

  test ':user presence validation' do
    a = Attempt.new
    assert_equal(false, a.validate)
    assert_includes(a.errors.keys, :user)
  end

  test ':statement presence validation' do
    a = Attempt.new
    assert_equal(false, a.validate)
    assert_includes(a.errors.keys, :statement)
  end

  test ':user existence validation' do
    u = users(:plain_user)
    user_id = u.id
    a = Attempt.new(user_id: user_id)
    assert_not_includes(a.errors.keys, :user) unless a.validate
    u.delete

    a = Attempt.new(user_id: user_id)
    assert_equal(false, a.validate)
    assert_includes(a.errors.keys, :user)
  end

  test ':statement existence validation' do
    s = statements(:one)
    a = Attempt.new(statement_id: s.id)

    assert_not_includes(a.errors.keys, :statement) unless a.validate
    s.destroy!

    a = Attempt.new(statement_id: s.id)
    assert_equal(false, a.validate)
    assert_includes(a.errors.keys, :statement)
  end
end

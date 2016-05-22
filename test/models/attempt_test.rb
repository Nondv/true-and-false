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
end

require 'test_helper'

class StatementTest < ActiveSupport::TestCase
  def test_attributes
    model_attributes = Statement.columns_hash.map { |name, col| [name.to_sym, col.type.to_sym] }.to_h
    expected_attributes = { id: :integer,
                            ru: :text,
                            ru_explanation: :text,
                            value: :boolean,
                            points: :integer,
                            created_at: :datetime,
                            updated_at: :datetime }

    assert_equal(expected_attributes, model_attributes)
  end
end

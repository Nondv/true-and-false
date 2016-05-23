require 'test_helper'

class GameCardTest < ActiveSupport::TestCase
  setup do
    @attempt_1 = attempts(1)
    @statement_one = statements(:one)
  end

  test '#as_json method' do
    c = GameCard.new(@attempt_1, @statement_one)
    expected_hash = { id: @attempt_1.id,
                      text: @statement_one.ru }
    assert_equal(expected_hash, c.as_json)
  end
end

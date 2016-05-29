class Attempt < ApplicationRecord
  belongs_to :user
  belongs_to :statement

  def game_card
    raise 'not persisted' unless persisted?
    GameCard.new(self, statement)
  end

  def performed?
    !success.nil?
  end

  def points
    return 0 unless performed?

    success ? statement.points : (- statement.points / 2)
  end
end

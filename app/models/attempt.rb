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
end

#
# This class is hybrid of Attempt and Statement.
# It is used for responses to playing user.
#
# attributes:
#
# * :id - attempt.id
# * :text - statement.ru
#
# Explanation is not needed because it won't be sent to user 'til he answer.
#
class GameCard
  attr_reader :id, :text

  def initialize(attempt, statement)
    raise ArgumentError if !attempt.is_a?(Attempt) || !statement.is_a?(Statement)

    @attempt = attempt
    @statement = statement

    @id = attempt.id
    @text = statement.ru
  end

  #
  # Override default method
  #
  def as_json(options = {})
    { id: id, text: text }
  end
end

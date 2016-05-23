class StatementPolicy < ApplicationPolicy
  def access?
    user.is_a? Admin
  end

  alias index? access?
  alias update? access?
  alias create? access?
  alias destroy? access?
  alias show? access?
end

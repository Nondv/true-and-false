class StatementPolicy < ApplicationPolicy
  def index?
    true
  end

  def update?
    user.is_a? Admin
  end

  def create?
    update?
  end

  def destroy?
    update?
  end
end

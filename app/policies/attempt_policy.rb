class AttemptPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    user.is_a? Admin
  end

  def update?
    user.is_a? Admin
  end

  def create?
    true
  end

  def destroy?
    update?
  end

  class Scope < Scope
    def resolve
      user.is_a?(Admin) ? scope.all : scope.where(user_id: user.id)
    end
  end
end

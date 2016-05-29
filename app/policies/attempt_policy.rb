class AttemptPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    true
  end

  class Scope < Scope
    def resolve
      user.is_a?(Admin) ? scope.all : scope.where(user_id: user.id)
    end
  end
end

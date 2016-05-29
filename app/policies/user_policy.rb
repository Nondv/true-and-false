class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      user.is_a?(Admin) ? scope.all : scope.none
    end
  end
end

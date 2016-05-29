class UserPolicy < ApplicationPolicy
  def permitted_attributes
    [:email, :password, :password_confirmation]
  end

  class Scope < Scope
    def resolve
      user.is_a?(Admin) ? scope.all : scope.none
    end
  end
end

class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.where(role: 'seller')
      else
        scope.where(user_id: user.id)
      end
    end
  end

  def create?
    user.admin?
  end
  
  def edit?
    user.admin?
  end
  
  def update?
    user.admin?
  end

end
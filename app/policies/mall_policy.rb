class MallPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      end
    end
  end

  def new?
    user.admin?
  end
  
  def create?
    user.admin?
  end
  
  def edit?
    user.admin?
  end
  
  def update?
    new?
  end


end
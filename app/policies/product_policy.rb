class ProductPolicy < ApplicationPolicy
  
  class Scope < Scope
    def resolve
      if user.role == 'admin'
        scope.all
      else
        scope.where(user_id: user.id)
      end
    end
  end
  
  def create? 
    user && user.role == 'seller' || user.role == 'admin'
  end
  
  def new? 
    create?
  end

  def show?
    true
  end
  

  def destroy?
    edit?
  end
  
  def update?
    edit?
  end
  
  def edit?
    user.role == 'admin' || @record.user == user
  end
  
  
end

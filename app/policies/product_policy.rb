class ProductPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end
  
  def create? 
    user && user.role == 'seller' || user.role == 'admin'
  end
  
  def new? 
    create?
  end
  

  def destroy?
    create?
  end
  
  def update?
    create?
  end
  
  def edit?
    create?
  end
  
  
end

class ProductPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end
  
  def create? 
    user && user.role == 'seller'
  end
  
  def new? 
    user && user.role == 'seller'
  end
  
  def show?
    user && user.role == 'seller'
  end
  
  def destroy?
    user && user.role == 'seller'
  end
  
  def update?
    user && user.role == 'seller'
  end
  
  def edit?
    user && user.role == 'seller'
  end
  
  
end

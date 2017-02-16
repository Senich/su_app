class ProductPolicy < ApplicationPolicy
  
  class Scope < Scope
    def resolve
      if user.role == 'admin'
        scope.all
      else
        scope.where(company_id: user.company_id)
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
    user.role == 'admin' || @record.company == user.company
  end
  
  
end

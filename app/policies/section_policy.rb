class SectionPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(company_id: user.company_id)
      end
    end
  end

  def new?
    user.admin?
  end

  def create?
    new?
  end
end
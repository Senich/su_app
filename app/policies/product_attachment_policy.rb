class ProductAttachmentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def destroy?
    user && user.role == 'seller' || user.role == 'admin'
  end

  def edit?
    destroy?
  end
end

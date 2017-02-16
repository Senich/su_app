class DashboardPolicy < Struct.new(:user, :dashboard)
  
  class Scope
    def resolve
      scope.all
    end
  end
  
  def show?
    true
  end
end

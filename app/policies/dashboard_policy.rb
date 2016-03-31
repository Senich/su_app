class DashboardPolicy < Struct.new(:user, :dashboard)
  
  class Scope < Struct.new(:user, :scope)
    def resolve
      scope
    end
  end
  
  def index?
    true
  end
end

class DashboardPolicy < Struct.new(:user, :dashboard)
  class Scope < Scope
    def resolve
      scope
    end
  end
  
  def index?
    true
  end
  
  
end

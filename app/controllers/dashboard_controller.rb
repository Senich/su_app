class DashboardController < ApplicationController
  def index
    # authorize :dashboard, :index?
    skip_policy_scope
  end
end

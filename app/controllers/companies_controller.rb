class CompaniesController < ApplicationController

  def index
    @companies = policy_scope(Company)
  end

  def new
    @company = Company.new
    authorize @company
  end

end

class CompaniesController < ApplicationController

  def index
    @companies = policy_scope(Company)
  end

  def new
    @company = Company.new
    authorize @company
    @section = @company.sections.build
  end

  private

  def company_params
    params.require(:company).permit(:name, sections_attributes: [:address_id, :location])
  end

end

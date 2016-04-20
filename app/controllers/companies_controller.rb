class CompaniesController < ApplicationController

  def index
    @companies = policy_scope(Company)
  end

  def new
    @company = Company.new
    @section = @company.sections.new
    authorize @company
  end
  
  def create
    @company = Company.new(company_params)
    authorize @company
    if @company.save
      flash[:success] = 'Компания успешно добавлена'
      redirect_to companies_path
    else
      flash[:danger] = "Не удалось создать компанию"
      render :new
    end
  end

  private

  def company_params
    params.require(:company).permit(:name, sections_attributes: [:address_id, :location, :_destroy])
  end

end

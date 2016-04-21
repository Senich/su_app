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
      flash[:success] = "Компания #{@company.name} успешно создана"
      redirect_to companies_path
    else
      flash[:danger] = 'Не удалось создать компанию'
      render :new
    end
  end

  def edit
    @company = Company.find(params[:id])
    authorize @company
  end

  def update
    @company = Company.find(params[:id])
    authorize @company
    if @company.update_attributes(company_params)
      flash[:success] = "Сведения о компании #{@company.name} успешно обновлены"
      redirect_to companies_path
    else
      flash[:danger] = "Не удалось обновить сведения о компании #{@company.name}"
      render :edit
    end
  end

  private

  def company_params
    params.require(:company).permit(:name, sections_attributes: [:id, :address_id, :location, :_destroy])
  end

end

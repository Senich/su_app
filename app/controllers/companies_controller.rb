class CompaniesController < ApplicationController

  before_action :set_company, only: [:destroy, :update, :edit, :show]

  def index
    @companies = policy_scope(Company)
  end

  def new
    @company = Company.new
    @section = @company.sections.build
    @contact = @section.build_contact
    @phone = @contact.phones.build
    # binding.pry
    authorize @company
  end

  def show
    session[:company_id] = @company.id
  end

  def create
    @company = Company.new(company_params)
    # @company.malls << @company.sections.last.mall
    authorize @company
    # binding.pry
    if @company.save
      flash[:success] = "Компания #{@company.name} успешно создана"
      redirect_to company_path(@company)
    else
      flash.now[:danger] = 'Не удалось создать компанию'
      render :new
    end
  end

  def edit
  end

  def update

    if @company.update_attributes(company_params)
      flash[:success] = "Сведения о компании #{@company.name} успешно обновлены"
      redirect_to @company
    else
      flash.now[:danger] = "Не удалось обновить сведения о компании #{@company.name}"
      render :edit
    end
  end

  def destroy
    if @company.destroy
      flash[:success] = "Компания #{@company.name} была успешно удалена"
      redirect_to companies_path
    else
      flash.now[:danger] = "Не удалось удалить компанию #{@company.name}"
    end
  end

  private

  def company_params
    params.require(:company).permit(:name, :details, sections_attributes: [:id, :mall_id, :location, :_destroy, 
       contact_attributes: [:id, :email, :details, :destroy, phones_attributes: [:id, :number, :extension, :notes, :_destroy]]] )
  end

  def set_company
    @company = Company.find(params[:id])
    authorize @company
  end

end

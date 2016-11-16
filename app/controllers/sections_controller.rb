class SectionsController < ApplicationController
  
  before_action :set_section, only: [:destroy, :update, :edit, :show]

  def new
    @section = Section.new
    @company = Company.find(session[:company_id])
    @contact = @section.build_contact
    @phone = @contact.phones.build
    authorize @section
  end
  
  def show
    
  end

  def create
    #находим компанию по информации из session которую пихнули в экшне show
    @company = Company.find(session[:company_id])
    @section = Section.new(section_params)
    #добавляем ссылку на компанию, которой принадлежит секция
    @section.company_id = @company.id
    authorize @section
    if @section.save
      flash[:success] = "Адрес для #{@company.name} успешно добавлен"
      session[:company_id] = nil
      redirect_to company_path(@company)
    else
      flash.now[:danger] = "Не удалось создать адрес для #{@company.name}"
      @contact = @section.build_contact
      @phone = @contact.phones.build
      render :new
    end
  end


  private

  def section_params
    params.require(:section).permit(:location, :company_id, :mall_id,
       contact_attributes: [:id, :email, :details, :_destroy,
       phones_attributes: [:id, :number, :extension, :notes, :_destroy]])
  end
  
  def set_section
    @section = Section.find(params[:id])
    authorize @section
  end
end

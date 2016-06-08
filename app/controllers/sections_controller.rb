class SectionsController < ApplicationController


  def new
    @section = Section.new
    @company = Company.find(session[:company_id])
    @contact = @section.build_contact
    @phone = @contact.phones.build
    authorize @section
  end

  def create
    company = Company.find(session[:company_id])
    @section = Section.new(section_params)
    @section.company_id = company.id
    authorize @section
    if @section.save
      flash[:success] = "Адрес для #{company.name} успешно добавлен"
      session[:company_id] = nil
      redirect_to section_path(@section)
    else
      flash.now[:danger] = "Не удалось создать адрес для #{company.name}"
      render :new
    end
  end


  private

  def section_params
    params.require(:section).permit(:location, :company_id, :mall_id,
       contact_attributes: [:id, :email, :details, :_destroy,
       phones_attributes: [:id, :number, :extension, :notes, :_destroy]])
  end
end

class MallsController < ApplicationController
  
  before_action :set_mall, only: [:edit, :show, :update, :destroy]

  def index
    @malls = policy_scope(Mall)
  end

  def new
    @mall = Mall.new
    @contact = @mall.build_contact
    @phone = @contact.phones.build
    authorize @mall
  end
  
  def show
  end
  
  def edit
  end
  
  def create
    @mall = Mall.create(mall_params)
    authorize @mall
    if @mall.save
      flash[:success] = "ТЦ #{@mall.name} успешно создан"
      redirect_to @mall
    else
      flash.now[:danger] = "Не удалось создать новый ТЦ"
      render :new
    end
  end
  
  def update
    if @mall.update_attributes(mall_params)
      flash[:success] = "Сведения о ТЦ #{@mall.name} успешно обновлены"
      redirect_to @mall
    else
      flash.now[:danger] = "Не удалось обновить сведения о ТЦ #{@mall.name}"
      render :edit
    end
  end
  
  def destroy
    if @mall.destroy
      flash[:success] = "#{@mall.name} успешно удалён"
      redirect_to malls_path
    else
      flash[:danger] = "Не удалось удалить #{@mall.name}"
    end
  end
  
  
  private
  
  def mall_params
    params.require(:mall).permit(:name, :about, :street, :city, :building, contact_attributes: [:id, :email, :details, :_destroy,
      phones_attributes: [:id, :number, :contact_id, :notes, :extension, :_destroy]])
  end
  
  def set_mall
    @mall = Mall.find(params[:id])
    authorize @mall
  end

end

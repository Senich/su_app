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
  
  def create
    @mall = Mall.create(mall_params)
    authorize @mall
    # binding.pry
    if @mall.save
      flash[:success] = "ТЦ #{@mall.name} успешно создан"
      redirect_to @mall
    else
      flash.now[:danger] = "Не удалось создать новый ТЦ"
      render :new
    end
  end
  
  
  private
  
  def mall_params
    params.require(:mall).permit(:name, :details, :street, :city, :building, contact_attributes: [:id, :email, :details, :contactable_id, :contactable_type, :_destroy,
      phones_attributes: [:id, :number, :contact_id, :notes, :extension, :_destroy]])
  end
  
  def set_mall
    @mall = Mall.find(params[:id])
    authorize @mall
  end

end

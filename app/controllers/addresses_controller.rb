class AddressesController < ApplicationController

  before_action :set_address, only: [:edit, :show, :update, :destroy]

  def index
    @addresses = policy_scope(Address)
  end

  def new
    @address = Address.new
    @phone = @address.phones.build
    authorize @address
  end

  def create
    @address = Address.create(address_params)
    authorize @address
    if @address.save
      # binding.pry
      flash[:success] = "Адрес #{@address.name} успешно добавлен"
      redirect_to address_path(@address)
    else
      flash.now[:danger] = 'Не удалось создать новый адрес'
      render :new
    end
  end

  def edit
  end

  def show
  end

  def destroy
    if @address.destroy
      flash[:success] = "Адрес #{@address.name} успешно удалён"
      redirect_to addresses_path
    else
      flash.now[:danger] = 'Не удалось удалить адрес'
    end
  end

  def update
    if @address.update_attributes(address_params)
      # binding.pry
      flash[:success] = 'Данные успешно обновлены'
      redirect_to address_path(@address)
    else
      flash.now[:danger] = 'Не удалось обновить информацию об адресе'
      render :edit
    end
  end

  private

  def address_params
    params.require(:address).permit(:name, :street, :building, :city, phones_attributes: [:id, :number, :extension, :details] )
  end

  def set_address
    @address = Address.find(params[:id])
    authorize @address
  end

end

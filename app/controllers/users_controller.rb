class UsersController < ApplicationController
  
  before_action :set_user, only: [:edit, :update, :destroy, :show]
  

  def index
    @users = policy_scope(User)
  end

  def new
    @user = User.new(role: 'seller')
    authorize @user
  end
  
  def show
    authorize @user
  end

  def create
    @user = User.create(users_params)
    @user.make_seller!
    authorize @user
    if @user.save
      flash[:success] = "Пользователь #{@user.full_name} успешно создан"
      session[:company_id] = nil
      redirect_to users_path
    else
      flash.now[:danger] = 'Не удалось создать пользователя'
      render :new
    end
  end

  def edit
    authorize @user
  end

  def update
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    authorize @user
    if @user.update_attributes(users_params)
      flash[:success] = 'Сведения успешно обновлены'
      redirect_to users_path
    else
      flash.now[:danger] = 'Не удалось обновить сведения'
      render :edit
    end
  end

  def destroy
    authorize @user
    if @user.destroy
      flash[:success] = 'Продавец успешно удалён'
      redirect_to users_path
    else
      flash[:danger] = 'Не удалось удалить продавца'
    end
  end


  private

  def users_params
    params.require(:user).permit(:first_name, :last_name, :password, :password_confirmation, :email, :company_id)
  end
  
  def set_user
    @user = User.find(params[:id])
  end

end

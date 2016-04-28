class UsersController < ApplicationController

  def index
    @users = policy_scope(User)
  end

  def new
    @user = User.new(role: 'seller')
    authorize @user
  end

  def create
    @user = User.create(users_params)
    @user.make_seller!
    authorize @user
    if @user.save
      flash[:success] = "Пользователь #{@user.full_name} успешно создан"
      redirect_to users_path
    else
      flash.now[:danger] = 'Не удалось создать пользователя'
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
    authorize @user
  end

  def update
    @user = User.find(params[:id])
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
    @user = User.find(params[:id])
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

end

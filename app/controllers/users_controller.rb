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
    authorize @user
    if @user.save
      flash[:success] = "Пользователь #{@user.full_name} успешно создан"
      redirect_to users_path
    else
      render :new
    end
  end


  private

  def users_params
    params.require(:user).permit(:first_name, :last_name, :password, :password_confirmation, :email)
  end

end

class ProductsController < ApplicationController

before_action :authenticate_user!
before_action :set_product, except: [:index, :new, :create]

  def index
  	@products = current_user.products.all
  end

  def show

  end

  def new
    @product = Product.new
  end

  def create
  	@product = current_user.products.new(products_params)
  	if @product.save
  		flash[:success] = 'Товарная позиция успешно создана.'
  		redirect_to [current_user, @product]
  	else
  		flash[:danger] = 'Не удалось создать товарную позицию'
  		render 'new'
  	end
  end

  def edit

  end

  def update
    if @product.update(products_params)
      flash[:success] = "Сведения о товаре обновлены."
      redirect_to [current_user, @product]
    else
      flash[:danger] = "Не удалось обновить сведения о товаре"
      render :edit
    end
  end

  def destroy
    if @product.destroy
      flash[:success] = "Товарная позиция успешно удалена."
      redirect_to user_products_path(current_user)
    else
      flash[:danger] = "Не удалось удалить товарную позицию"
    end
  end

  private 

  def products_params
  	params.require(:product).permit(:name, :width, :height, :depth, :color, :price, :category, :description)
  end

  def set_product  	
  	@product = current_user.products.find(params[:id])
  end

end
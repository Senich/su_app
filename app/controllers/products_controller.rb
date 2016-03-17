class ProductsController < ApplicationController

before_action :authenticate_user!
before_action :set_product, except: [:index, :new, :create]

  def index
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

  private 

  def products_params
  	params.require(:product).permit(:name, :width, :height, :depth, :color, :price, :product_category, :description)
  end

end
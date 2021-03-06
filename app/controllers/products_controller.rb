class ProductsController < ApplicationController

before_action :authenticate_user!, except: :show
before_action :set_product, except: [:index, :new, :create]
before_action :authorize_product, except: [:index, :new, :create]



  def index
  	@products = policy_scope(Product)
  end

  def show
    @product_attachments = @product.product_attachments.all
  end

  def new
    @product = Product.new
    authorize @product
    @company = current_user.company
    @product_attachment = @product.product_attachments.new
  end

  def create
  	@product = current_user.company.products.new(products_params)
  	authorize @product
  	if @product.save
      # если картинки приложены то создаём соответствующую запись
      if params[:product_attachments] != nil
        params[:product_attachments]['picture'].each do |p|
          @product_attachment = @product.product_attachments.create!(picture: p)
        end
      end
  		flash[:success] = 'Товарная позиция успешно создана.'
  		redirect_to  @product
  	else
  		flash.now[:danger] = 'Не удалось создать товарную позицию'
  		render :new
  	end
  end

  def edit
    
  end

  def update
    if @product.update_attributes(products_params)
      if params[:product_attachments] != nil
        params[:product_attachments]['picture'].each do |p|
          @product_attachment = @product.product_attachments.create(:picture => p) if @product.product_attachments.size < 6
        end
      end
      flash[:success] = 'Сведения о товаре обновлены.'
      redirect_to @product
    else
      flash.now[:danger] = 'Не удалось обновить сведения о товаре'
      render :edit
    end
  end

  def destroy
    if @product.destroy
      flash[:success] = 'Товарная позиция успешно удалена.'
      redirect_to company_products_path(current_user.company_id)
    else
      flash.now[:danger] = 'Не удалось удалить товарную позицию'
    end
  end

  private

  def products_params
  	params.require(:product).permit(:name, :width, :height, :depth, :color, :price, :category, :description,
    product_attachments_attributes: [:id, :product_id, :picture, :remove_picture])
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def authorize_product
    authorize @product
  end

end

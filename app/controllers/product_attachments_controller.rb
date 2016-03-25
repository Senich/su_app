class ProductAttachmentsController < ApplicationController
  def edit
    @product_attachment = ProductAttachment.find(params[:id])
  end

  def destroy
    @product_attachment = ProductAttachment.find(params[:id])
    if @product_attachment.destroy
      flash[:success] = "Изображение удалено!"
      redirect_to :back
    end
  end
end

class ProductAttachmentsController < ApplicationController


  def edit
    @product_attachment = ProductAttachment.find(params[:id])
    authorize @product_attachment
  end

  def destroy
    @product_attachment = ProductAttachment.find(params[:id])
    authorize @product_attachment
    if @product_attachment.destroy
      flash[:success] = 'Изображение удалено!'
      redirect_to :back
    end
  end

  private


end

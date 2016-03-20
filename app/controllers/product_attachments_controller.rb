class ProductAttachmentsController < ApplicationController
  def edit
    @product_attachment = ProductAttachment.find(params[:id])
  end
end

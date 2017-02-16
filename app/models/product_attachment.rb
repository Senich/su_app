class ProductAttachment < ActiveRecord::Base
  mount_uploader :picture, PictureUploader
  belongs_to :product, inverse_of: :product_attachments
  after_destroy :delete_picture

  private
    def delete_picture
      self.remove_picture!
    end

end

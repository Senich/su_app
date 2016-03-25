class ProductAttachment < ActiveRecord::Base
  mount_uploader :picture, PictureUploader
  belongs_to :product
  after_destroy :delete_picture

  private
    def delete_picture
      self.remove_picture!
    end

end

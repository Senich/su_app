class ProductAttachment < ActiveRecord::Base
  mount_uploader :picture, PictureUploader
  belongs_to :product
end

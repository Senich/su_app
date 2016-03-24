class Product < ActiveRecord::Base
  belongs_to :user
  has_many :product_attachments
  accepts_nested_attributes_for :product_attachments
  # validates :product_attachments, presence: true
end

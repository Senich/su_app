class Product < ActiveRecord::Base
  belongs_to :user
  has_many :product_attachments, dependent: :destroy, inverse_of: :product
  accepts_nested_attributes_for :product_attachments
  validate :validate_attachments_count


  def validate_attachments_count
    if self.product_attachments.count > 6
      errors.add(:product_attachments, 'Количество изображений не может быть больше 6')
    end
  end
end

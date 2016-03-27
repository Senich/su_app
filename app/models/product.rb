class Product < ActiveRecord::Base
  belongs_to :user
  has_many :product_attachments, dependent: :destroy
  accepts_nested_attributes_for :product_attachments
  validate :validate_attachments_count


  def validate_attachments_count
    if self.product_attachments.size > 6
      errors.add(:product_attachments, 'Количество изображений не может быть больше трёх')
    end
  end
end

class Product < ActiveRecord::Base
  belongs_to :company
  has_many :product_attachments, dependent: :destroy, inverse_of: :product
  accepts_nested_attributes_for :product_attachments, reject_if: proc { |attributes| attributes['picture'].blank? }
  validates :name, :category, presence: true
  validates :price, numericality: true 
  validates :width, :depth, :height, :color, presence: true
  validate :validate_attachments_count
 

  def validate_attachments_count
    # puts "Count shows there are " + product_attachments.count.to_s + " attachments."  # always returns zero
    # puts "Size shows there are " + product_attachments.size.to_s + " attachments."
    errors.add(:product_attachments, 'Количество изображений не может быть больше 6') if product_attachments.size > 6
  end
  
end

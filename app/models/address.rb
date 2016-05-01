class Address < ActiveRecord::Base
  has_many :sections
  has_many :companies, through: :sections
  has_many :phones, as: :phoneable
  
  accepts_nested_attributes_for :phones, allow_destroy: true
  
  validates :city, :street, :building, :name, presence: true

  def full_address
    "#{city}, #{street}, #{building}"
  end
end

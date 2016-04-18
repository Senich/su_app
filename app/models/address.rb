class Address < ActiveRecord::Base
  has_many :sections
  has_many :companies, through: :sections
  validates :city, :street, :building, presence: true


  def full_address
    "#{city}, #{street}, #{building}"
  end
end

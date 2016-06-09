class Mall < ActiveRecord::Base
  
  has_many :companies, through: :sections
  has_many :sections, dependent: :destroy
  has_one :contact, as: :contactable, dependent: :destroy
  accepts_nested_attributes_for :contact, allow_destroy: true


  def full_address
    "#{city}, #{street}, #{building}"
  end


end

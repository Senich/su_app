class Mall < ActiveRecord::Base

  has_and_belongs_to_many :companies
  has_many :locations
  has_one :contact, as: :contactable, dependent: :destroy
  accepts_nested_attributes_for :contact, allow_destroy: true


  def full_address
    "#{city}, #{street}, #{building}"
  end


end

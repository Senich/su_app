class Mall < ActiveRecord::Base
  
  has_many :companies, through: :sections
  has_many :sections, dependent: :destroy
  has_one :contact, as: :contactable, dependent: :destroy
  accepts_nested_attributes_for :contact, allow_destroy: true

  validates :name, :city, :street, :building, :contact, presence: true
  validates_uniqueness_of :name
  validates_length_of :details, minimum: 10, too_short: 'Описание ТЦ должно быть более подробным', allow_blank: true


  def full_address
    "#{city}, #{street}, #{building}"
  end


end

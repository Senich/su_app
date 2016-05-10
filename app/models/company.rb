class Company < ActiveRecord::Base
  
  has_many :sections, inverse_of: :company, dependent: :destroy
  has_many :addresses, through: :sections
  has_many :users, -> { where role: 'seller'}, dependent: :destroy
  has_many :products
  
  accepts_nested_attributes_for :sections, allow_destroy: true

  validates :name, presence: true, uniqueness: true

  def get_section_location_at_address(address)
    sections.where(company_id: id, address_id: address.id).first.location
  end

  def get_section_phone_at_address(address)
    sections.where(company_id: id, address_id: address.id).first.phone
  end

  def get_section_at_address(address)
    sections.where(company_id: id, address_id: address.id).first
  end

end

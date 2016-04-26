class Company < ActiveRecord::Base
  
  has_many :sections, inverse_of: :company, dependent: :destroy
  has_many :addresses, through: :sections
  has_many :users, -> { where role: 'seller'}, dependent: :destroy
  
  accepts_nested_attributes_for :sections, allow_destroy: true

  validates :name, presence: true, uniqueness: true

  def get_section_at_address(address)
    sections.where(company_id: id, address_id: address.id).first.location
  end

end

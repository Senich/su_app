class Section < ActiveRecord::Base
  belongs_to :address
  belongs_to :company
  
  has_one :phone, as: :phoneable
  accepts_nested_attributes_for :phone

  validates :location, uniqueness: true, allow_blank: true
end

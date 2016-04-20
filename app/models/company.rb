class Company < ActiveRecord::Base
  
  has_many :sections, inverse_of: :company
  has_many :addresses, through: :sections
  has_many :users, -> { where role: 'seller'}
  
  accepts_nested_attributes_for :sections, allow_destroy: true

  validates :name, presence: true, uniqueness: true

end

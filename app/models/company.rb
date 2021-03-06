class Company < ActiveRecord::Base
  
  has_many :malls, through: :sections
  has_many :sections, dependent: :destroy
  has_one :contact, as: :contactable
  has_many :users, -> { where role: 'seller'}, dependent: :destroy
  has_many :products, dependent: :destroy

  accepts_nested_attributes_for :contact, allow_destroy: true
  
  validates_presence_of :name

end
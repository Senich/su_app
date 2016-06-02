class Company < ActiveRecord::Base

  has_and_belongs_to_many :malls
  has_many :sections
  has_one :contact, as: :contactable
  has_many :users, -> { where role: 'seller'}, dependent: :destroy
  has_many :products, dependent: :destroy

  accepts_nested_attributes_for :sections, allow_destroy: true

end
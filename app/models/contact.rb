class Contact < ActiveRecord::Base

  belongs_to :contactable, polymorphic: true
  has_many :phones, dependent: :destroy
  accepts_nested_attributes_for :phones, allow_destroy: true

end
class Location < ActiveRecord::Base
  belongs_to :company
  belongs_to :mall
  has_many :contacts, as: :contactable

  accepts_nested_attributes_for :contacts, allow_destroy: true

end
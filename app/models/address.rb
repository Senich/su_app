class Address < ActiveRecord::Base
  has_many :sections
  has_many :companies, through: :sections
end

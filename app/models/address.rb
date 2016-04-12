class Address < ActiveRecord::Base
  has_many :local_addresses
  has_many :companies, through: :local_addresses
end

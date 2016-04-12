class Company < ActiveRecord::Base
  has_many :sections
  has_many :addresses, through: :sections
  has_many :users, -> { where role: 'seller'}
end

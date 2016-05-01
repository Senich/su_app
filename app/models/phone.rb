class Phone < ActiveRecord::Base
  
  belongs_to :phoneable, polymorphic: true
  
  validates :number, presence: true
  
end

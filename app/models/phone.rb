class Phone < ActiveRecord::Base
  belongs_to :contact
  validates :number, presence: true, numericality: true, length: { minimum: 7, maximum: 11}
end
class Section < ActiveRecord::Base
    
    belongs_to :company
    belongs_to :mall
    has_one :contact, as: :contactable, dependent: :destroy
    accepts_nested_attributes_for :contact, allow_destroy: true
end

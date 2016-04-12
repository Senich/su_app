class Section < ActiveRecord::Base
  belongs_to :address
  belongs_to :company
end

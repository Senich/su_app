require 'rails_helper'

RSpec.describe Company, type: :model do
  
  it 'Компания должна иметь обязательные атрибуты' do
    should validate_presence_of(:name)
  end
  
  it 'Компания может иметь опциональные атрибуты' do
    should_not validate_presence_of(:details)
  end
  
    
end
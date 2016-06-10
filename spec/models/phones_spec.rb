require 'rails_helper'

RSpec.describe Phone, type: :model do

  it 'должен иметь длину от 7 до 11 символов' do
    validate_length_of(:number)
  end
  
  it 'должен иметь обязательные поля' do
    should validate_presence_of(:number)
  end
  
  it 'должен иметь поля не обязательные для заполнения' do
    should_not validate_presence_of(:notes)
    should_not validate_presence_of(:extension)
  end
  
  it 'должен принадлежать к объекту Contact' do
    should belong_to(:contact)
  end

end
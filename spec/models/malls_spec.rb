require 'rails_helper'

RSpec.describe Mall, type: :model do

  it 'ТЦ должна иметь обязательные атрибуты' do
    should validate_presence_of(:name)
    should validate_presence_of(:city)
    should validate_presence_of(:street)
    should validate_presence_of(:building)
    should validate_presence_of(:contact)
  end

  it 'Имя ТЦ должно быть уникальным' do
    should validate_uniqueness_of(:name)
  end

  it 'Компания может иметь опциональные атрибуты' do
    # should_not validate_presence_of()
  end

  it 'Компания должна иметь следующие реляционные отношения' do
    should have_many(:companies)
    should have_many(:sections)
    should have_one(:contact)
    should accept_nested_attributes_for(:contact)
  end


end
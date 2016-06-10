require 'rails_helper'

RSpec.describe Product, type: :model do
    

    it 'Товар имеет валидную фабрику' do
      expect(FactoryGirl.build(:product)).to be_valid
    end
    
    it 'Товар должен иметь обязательные атрибуты' do
      should validate_presence_of(:name)
      should validate_numericality_of(:price)
    end
    
    it 'Имя товара может быть не уникальным' do
      should_not validate_uniqueness_of(:name)
    end

    it 'Товар имеет валидную фабрику со множеством аттачей' do
      @product = create(:product_with_attachments)
      expect(@product.product_attachments.size).to be > 0
    end

    it 'Товар не должен иметь более 6 приложенных изображений' do
      @product = create(:product_with_attachments, attachments_count: 10)
      expect(@product).not_to be_valid
    end
    
    

end

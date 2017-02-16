require 'rails_helper'

RSpec.describe Product, type: :model do
    

    it 'Товар имеет валидную фабрику' do
      @product = create(:product_with_attachments, attachments_count: 2)
      expect(@product.product_attachments.count).to eq 2
      expect(@product).to be_valid
    end
    
    it 'Товар должен иметь обязательные атрибуты' do
      should validate_presence_of(:name)
      should validate_numericality_of(:price)
      should validate_presence_of(:category)
      should validate_presence_of(:width)
      should validate_presence_of(:height)
      should validate_presence_of(:depth)
    end
    
    it 'Имя товара может быть не уникальным' do
      should_not validate_uniqueness_of(:name)
    end

    it 'Товар имеет валидную фабрику со множеством аттачей' do
      @product = create(:product_with_attachments)
      expect(@product.product_attachments.size).to be > 0
      expect(@product).to be_valid
    end

    it 'Товар не должен иметь более 6 приложенных изображений' do
      @product = create(:product_with_attachments, attachments_count: 7)
      expect(@product).not_to be_valid
    end
    
    # it 'Товар должен иметь как минимум 1 аттач' do
    #   @product = create(:product)
    #   expect(@product).not_to be_valid
    # end

end

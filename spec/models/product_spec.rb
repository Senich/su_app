require 'rails_helper'

RSpec.describe Product, type: :model do
    

    it 'Товар имеет валидную фабрику' do
      expect(FactoryGirl.build(:product)).to be_valid
    end
    
    it 'Товар не может не иметь имени' do
      expect(FactoryGirl.build(:product, name: nil)).not_to be_valid
    end

    it 'Товар имеет валидную фабрику со множеством аттачей' do
      @product = FactoryGirl.create(:product_with_attachments)
      expect(@product.product_attachments.size).to be > 0
    end

    it 'Товар не должен иметь более 6 приложенных изображений' do
      @product = FactoryGirl.create(:product_with_attachments, attachments_count: 10)
      expect(@product).not_to be_valid
    end
    
    

end

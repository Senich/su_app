require 'rails_helper'

RSpec.describe Product, type: :model do
    
    before :each do
      @product = Product.new()
    end
    
    it 'is invalid without name' do
      expect(@product).to be_invalid
      @product.name = 'Stool'
      @product.height = 100
      @product.width = 100
      @product.depth = 100
      @product.color = 'white'
      expect(@product).to be_valid
    end
    
    

end

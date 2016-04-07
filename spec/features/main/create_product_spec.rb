require 'rails_helper'

RSpec.feature 'Создание продукта' do

  before do
    @john = FactoryGirl.create(:user, :seller)
    login_as(@john)
  end


  scenario 'Пользователь создаёт продукт' do
    visit '/'
    click_link 'Личный кабинет'
    expect(page.current_path).to eq(user_products_path(@john))
    expect(page).to have_content('Мои товарные позиции')
    click_link 'Добавить товар'
    
    expect {
      select 'Кухонная мебель', from: 'product[category]'
      fill_in 'Наименование', with: 'Кухонный стул'
      fill_in 'Ширина', with: 50
      fill_in 'Глубина', with: 60
      fill_in 'Высота', with: 100
      select 'Чёрный', from: 'product[color]'
      fill_in 'Стоимость', with: 1490.00
      fill_in 'Описание', with: 'Прекрасный кухонный стул из шведской сосны'
      click_button 'Создать товарную позицию'
    }.to change(Product, :count).by(1)
    
    expect(page).to have_content 'Товарная позиция успешно создана.'
    product = Product.last
    expect(page.current_path).to eq(user_product_path(@john, product))
    click_link 'Личный кабинет'
    expect(page).to have_content(product.name)
  end

end
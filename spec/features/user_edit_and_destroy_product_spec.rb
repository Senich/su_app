require 'rails_helper'

RSpec.feature 'Пользователь' do

  before do
   
    @john = FactoryGirl.create(:user_with_products, :seller)
    @john_product = @john.products.first
   
    login_as(@john)
  end

  scenario 'вводит корректные новые данные' do
    expect(@john.products.count).to eq(1)
    visit '/'
    click_link 'Личный кабинет'
    link = "a[href='/users/#{@john.id}/products/#{@john_product.id}/edit']"
    find(link).click
    fill_in 'Стоимость', with: 999
    fill_in 'Наименование', with: 'Super chair'
    click_button 'Сохранить'

    expect(page).to have_content('Сведения о товаре обновлены.')
    expect(page).to have_content(999)
    expect(page).to have_content('Super chair')
    expect(page).not_to have_content('Nice chair')
  end

  scenario 'удаляет товар' do
    visit '/'
    click_link 'Личный кабинет'
    link = "//a[contains(@href, '/users/#{@john.id}/products/#{@john_product.id}') and .//text()='Удалить'] "
    find(:xpath, link).click
    expect(page).to have_content('Товарная позиция успешно удалена.')
  end


end
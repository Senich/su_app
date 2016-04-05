require 'rails_helper'

RSpec.feature 'Пользователь(seller)' do

  before :each do
   
    @john = FactoryGirl.create(:user_with_products, :seller)
    @john_product = @john.products.first
    
  end

  scenario 'вводит корректные новые данные' do
    login_as(@john)
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
    login_as(@john)
    visit '/'
    click_link 'Личный кабинет'
    link = "//a[contains(@href, '/users/#{@john.id}/products/#{@john_product.id}') and .//text()='Удалить'] "
    find(:xpath, link).click
    expect(page).to have_content('Товарная позиция успешно удалена.')
  end
  
  scenario 'другой селлер не может удалять или редактировать товары первого' do
    @pete = FactoryGirl.create(:user, :seller, email: 'pete@exampl.com')
    login_as(@pete)
    visit "/users/#{@john.id}/products/#{@john_product.id}/edit"
    expect(page).to have_content("Вы не авторизованы на выполнение этого действия!")
  end
  
  scenario 'администратор может редактировать чужие товары' do
    @pete = FactoryGirl.create(:user, :admin, email: 'pete@exampl.com')
    login_as(@pete)
    visit "/users/#{@john.id}/products/#{@john_product.id}/edit"
    expect(page).to have_content ("Редактирование информации о товаре #{ @john_product.name }")
  end
  
  
end
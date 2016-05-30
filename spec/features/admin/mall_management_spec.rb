require 'rails_helper'

feature 'Управление мебельными центрами' do

  before :each do
    @admin = create(:user, :admin)
    login_as(@admin)
  end

  scenario 'создание торгового центра' do
    visit admin_path
    click_link 'Мебельные центры'
    expect(page).to have_content 'Список зарегистрированых торговых центров и магазинов'
    click_link 'Добавить ТЦ'
    expect {
      fill_in 'Название', with: 'Мебель-сити'
      select 'Москва', from: 'mall[city]'
      fill_in 'Улица', with: 'Проспект Просвещения'
      fill_in 'Дом', with: '23А'
      fill_in 'Email', with: 'mebel@city.com'
      fill_in 'Телефон', with: 2339841
      fill_in 'Доб.', with: 224
      fill_in 'Примечания', with: 'Телефон секретаря'
      fill_in 'Описание', with: 'Самый крутой мебельный центр в городе'
      click_button 'Создать ТЦ'
    }.to change(Mall, :count).by(1)
    mall = Mall.last
    expect(page).to have_content "ТЦ #{mall.name} успешно создан"
    expect(page.current_path).to eq(mall_path(mall))
    expect(page).to have_content '233-98-41'
    expect(page).to have_content 'mebel@city.com'
    expect(page).to have_content mall.full_address
  end

end
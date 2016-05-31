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

  scenario 'редактирование сведений о ТЦ' do
    @mall = create(:mall)
    #проверяем нормально ли создались связанные объекты
    expect(@mall.contact).not_to be_nil
    expect(@mall.contact.phones.first).not_to be_nil
    visit malls_path
    link = "a[href='/malls/#{@mall.id}/edit']"
    find(link).click
    fill_in 'Название', with: 'MEGA'
    select 'Москва', from: 'mall[city]'
    fill_in 'Улица', with: 'Невский проспект'
    fill_in 'Дом', with: '22'
    fill_in 'Email', with: 'mebel@mega.com'
    fill_in 'Телефон', with: '9213522103'
    fill_in 'Доб.', with: '110'
    fill_in 'Примечания', with: 'Телефон рецепции'
    fill_in 'Описание', with: 'MEGAMALL'
    click_button 'Обновить сведения'
    expect(page).to have_content 'Сведения о ТЦ MEGA успешно обновлены'
    expect(page).to have_content 'MEGA'
    expect(page).to have_content 'Невский проспект'
    expect(page).to have_content '22'
    expect(page).to have_content 'mebel@mega.com'
    expect(page).to have_content '(921) 352-21-03'
    expect(page).to have_content 'MEGAMALL'
  end

end
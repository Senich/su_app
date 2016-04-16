require 'rails_helper'

feature 'Управление адресами' do

  before :each do
    @admin = create(:user, :admin)
    login_as(@admin)
  end

  scenario 'админ создаёт адрес мебельного ТЦ' do
    visit admin_path
    click_link 'Адреса'
    expect(page).to have_content('Управление адресами')
    click_link 'Добавить новый адрес'
    expect {
      select 'Москва', from: 'address[city]'
      fill_in 'Улица', with: 'Московский проспект'
      fill_in 'Здание', with: '2а'
      fill_in 'Название магазина или ТЦ', with: 'Мебель-сити'
      click_button 'Добавить адрес'
    }.to change(Address, :count).by(1)
    expect(page).to have_content('Адрес Мебель-сити успешно добавлен')
    address = Address.last
    expect(page.current_path).to eq(address_path(address))
  end

  scenario 'админ редактирует адресс созданного ТЦ или магазина' do
    @address = create(:address)
    visit address_path(@address)
    expect(page).to have_content(@address.name)
    expect(page).to have_content(@address.street)
    expect(page).to have_content(@address.building)
    click_link 'Редактировать'
    select 'Санкт-Петербург', from: 'address[city]'
    fill_in 'Улица', with: 'Ленинградский проспект'
    fill_in 'Здание', with: '22'
    click_button 'Обновить данные'
    expect(page).to have_content('Ленинградский проспект')
    expect(page).to have_content('22')
    expect(page).to have_content('Санкт-Петербург')
  end

  scenario 'админ удаляет созданный адрес' do
    @address = create(:address)
    visit address_path(@address)
    expect {
      link = "//a[contains(@href,'/addresses/#{@address.id}') and .//text()='Удалить']"
      page.find(:xpath, link).click
    }.to change(Address, :count).by(-1)
    expect(page).to have_content("Адрес #{@address.name} успешно удалён")
    expect(page.current_path).to eq(addresses_path)
  end


end
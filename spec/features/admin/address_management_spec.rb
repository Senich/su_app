require 'rails_helper'

feature 'Управление адресами' do

  before :each do
    @admin = create(:user, :admin)
    login_as(@admin)
  end

  scenario 'админ создаёт адрес мебельного ТЦ' do
    # visit admin_path
    # click_link 'Адреса'
    # expect(page).to have_content('Управление адресами')
    # click_link 'Добавить новый адрес'
    # expect {
    #   select 'Москва', from: 'address[city]'
    #   fill_in 'Улица', with: 'Московский проспект'
    #   fill_in 'Дом', with: '2а'
    #   fill_in 'Название магазина или ТЦ', with: 'Мебель-сити'
    #   fill_in 'Телефон', with: '2325560'
    #   fill_in 'Добавочный', with: '227'
    #   click_button 'Добавить адрес'
    # }.to change(Address, :count).by(1)
    # expect(page).to have_content('Адрес Мебель-сити успешно добавлен')
    # address = Address.last
    # expect(page.current_path).to eq(address_path(address))
    # expect(page).to have_content('232-55-60')
    # expect(page).to have_content('Доб. 227')
  end

  scenario 'админ редактирует адресс созданного ТЦ или магазина' do
    # @address = create(:address)
    # visit address_path(@address)
    # expect(page).to have_content(@address.name)
    # expect(page).to have_content(@address.street)
    # expect(page).to have_content(@address.building)
    # click_link 'Редактировать'
    # select 'Санкт-Петербург', from: 'address[city]'
    # fill_in 'Улица', with: 'Ленинградский проспект'
    # fill_in 'Дом', with: '22'
    # click_button 'Обновить данные'
    # expect(page).to have_content('Ленинградский проспект')
    # expect(page).to have_content('22')
    # expect(page).to have_content('Санкт-Петербург')
  end

  scenario 'админ удаляет созданный адрес' do
    # @address = create(:address)
    # visit address_path(@address)
    # expect {
    #   link = "//a[contains(@href,'/addresses/#{@address.id}') and .//text()='Удалить']"
    #   page.find(:xpath, link).click
    # }.to change(Address, :count).by(-1)
    # expect(page).to have_content("Адрес #{@address.name} успешно удалён")
    # expect(page.current_path).to eq(addresses_path)
  end
  
  scenario 'На странице адреса отображаются все зарегистрированые компании' do
    # address = create(:address)
    # company1 = create(:company)
    # company2 = create(:company)
    # address.companies << company1
    # address.companies << company2
    # visit address_path(address)
    # expect(page).to have_content company1.name
    # expect(page).to have_content company2.name
  end


end
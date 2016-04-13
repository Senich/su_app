require 'rails_helper'

feature 'Управление пользователями' do

  before :each do
    @admin = create(:user, :admin)
    login_as(@admin)
  end

  scenario 'админ создаёт продавца' do
    visit root_path
    #ссылка на админку
    link = "//a[contains(@href, '/admin')]"
    page.find(:xpath, link).click
    expect(page).to have_content('Управление пользователями')
    expect(page).to have_content('Управление элементами приложения')
    click_link 'Управление пользователями'
    expect(page).to have_content('Список участников')
    click_link 'Добавить продавца'
    expect {
      fill_in 'E-mail', with: 'newuser@example.com'
      fill_in 'Пароль', with: 'secret123'
      fill_in 'Подтверждение пароля', with: 'secret123'
      fill_in 'Имя', with: 'John'
      fill_in 'Фамилия', with: 'Doe'
      click_button 'Добавить продавца'
    expect(page).to have_content('Пользователь John Doe успешно создан')
    }.to change(User, :count).by(1)
  end

  scenario 'админ редактирует продавца' do
    @johnny = create(:user, :seller)
    expect(@johnny.seller?)
    visit root_path
    link = "//a[contains(@href, '/admin')]"
    page.find(:xpath, link).click
    click_link 'Управление пользователями'
    link = "a[href='/users/#{@johnny.id}/edit']"
    find(link).click
    fill_in 'Имя', with: 'Johnny'
    click_button 'Обновить сведения'
    expect(page).to have_content 'Сведения успешно обновлены'
  end
  
  scenario 'админ удаляет продавца' do
    @johnny = create(:user, :seller)
    visit root_path
    link = "//a[contains(@href, '/admin')]"
    page.find(:xpath, link).click
    click_link 'Управление пользователями'
    expect {
      link = "//a[contains(@href,'/users/#{@johnny.id}') and .//text()='Удалить']"
      find(:xpath, link).click 
    }.to change(User, :count).by(-1)
    expect(page).to have_content('Продавец успешно удалён')
  end
  
  scenario 'админ создаёт адрес мебельного ТЦ' do
    visit admin_path
    click_link 'Адреса'
    expect(page).to have_content('Управление адресами')
    click_link 'Добавить новый адрес'
    expect {
      fill_in 'Город', with: 'Москва'
      fill_in 'Улица', with: 'Московский проспект'
      fill_in 'Здание', with: '2а'
      fill_in 'Название магазина или ТЦ', with: 'Мебель-сити'
      click_button 'Добавить компанию'
    }.to change(Company, :count).by(1)
    expect(page).to have_content("Адрес Мебель-сити успешно добавлен")
    company = Company.last
    expect(page.current_path).to eq(company_path(company))
  end
  
  scenario 'админ создаёт компанию' do
    visit admin_path
    click_link 'Управление компаниями'
    expect(page).to have_content('Список зарегистрированныых компаний')
    click_link 'Добавить компанию'
    fill_in 'Название', with: 'ООО Вектор'
    fill_in 'Город', with: 'Санкт-Петербург'
    fill_in 'Улица', with: 'Московский проспект'
    fill_in 'Дом', with: '23'
  end

end

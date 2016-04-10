require 'rails_helper'

feature 'Управление пользователями' do

  before :each do
    @admin = create(:user, :admin)
    login_as(@admin)
  end

  scenario 'админ заходит в админку' do
    visit root_path
    link = "//a[contains(@href, '/admin')]"
    page.find(:xpath, link).click
    expect(page).to have_content('Управление пользователями')
    expect(page).to have_content('Управление элементами приложения')
    click_link 'Управление пользователями'
    expect(page).to have_content('Список участников')
    click_link 'Добавить продавца'
    fill_in 'E-mail', with: 'newuser@example.com'
    # fill_in 'Компания', with: 'ООО Вектор'
    fill_in 'Пароль', with: 'secret123'
    fill_in 'Подтверждение пароля', with: 'secret123'
    fill_in 'Имя', with: 'John'
    fill_in 'Фамилия', with: 'Doe'
    click_button 'Добавить продавца'
    expect(page).to have_content('Пользователь John Doe успешно создан')

  end

end

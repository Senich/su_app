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
    fill_in 'Email', with: 'newuser@example.com'
    fill_in 'Компания', with: 'ООО Вектор'
    find('#password').fill_in 'Password', with: 'secret123'
    find('#password_confirmation').fill_in 'Password confirmation', with: 'secret123'
    click_button
  end

end

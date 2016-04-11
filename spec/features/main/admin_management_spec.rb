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
      # fill_in 'Компания', with: 'ООО Вектор'
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

end

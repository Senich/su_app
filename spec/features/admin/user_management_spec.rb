require 'rails_helper'

feature 'Управление пользователями' do

  before :each do
    @admin = create(:user, :admin)
    @company = create(:company_with_address, name: 'Мебельный магазин')
    create(:company_with_address)
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
      select 'Мебельный магазин', from: 'user[company_id]'
      click_button 'Добавить продавца'
    expect(page).to have_content('Пользователь John Doe успешно создан')
    }.to change(User, :count).by(1)
    user = User.last
    expect(user.company_id).to eq(@company.id)
    expect(page).to have_content(user.company.name)
    expect(page).to have_content(user.created_at.to_formatted_s(:db))
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
      page.click_link('', href: "/users/#{@johnny.id}")
      expect(page.current_path).to eq users_path
    }.to change(User, :count).by(-1)
    expect(page).to have_content('Продавец успешно удалён')
  end
  
  scenario 'админ просматривает сведения о продавце' do
    @pete = create(:user, :seller, company: @company)
    visit user_path(@pete)
    expect(page).to have_content @pete.full_name
    expect(page).to have_content @pete.company.name
  end


end

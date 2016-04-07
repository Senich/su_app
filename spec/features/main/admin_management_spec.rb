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
    expect(page).to have_content('Управление параметрами')
  end

end

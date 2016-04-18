require 'rails_helper'

feature 'Создание компании' do

  before :each do
    @admin = create(:user, :admin)
    login_as(@admin)
  end

  scenario 'админ создаёт компанию' do
    visit admin_path
    click_link 'Управление компаниями'
    expect(page).to have_content('Список зарегистрированных компаний')
    click_link 'Добавить компанию'
    fill_in 'Название', with: 'ООО Вектор'
    fill_in 'Город', with: 'Санкт-Петербург'
    fill_in 'Улица', with: 'Московский проспект'
    fill_in 'Дом', with: '23'
  end



end
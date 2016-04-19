require 'rails_helper'

feature 'Создание компании' do

  before :each do
    @admin = create(:user, :admin)
    create(:address)
    create(:address, city: 'Воронеж')
    
    login_as(@admin)
  end

  scenario 'админ создаёт компанию' do
    visit admin_path
    click_link 'Управление компаниями'
    expect(page).to have_content('Список зарегистрированных компаний')
    click_link 'Добавить компанию'
    fill_in 'Название', with: 'ООО Вектор'
    select 'Москва, Московский проспект, 32а', from: 'address'
    fill_in 'Номер секции', with: '12B'
    click_button 'Создать компанию'
  end



end
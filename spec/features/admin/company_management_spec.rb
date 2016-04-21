require 'rails_helper'

feature 'Управление компаниями' do

  before :each do
    @admin = create(:user, :admin)
    login_as(@admin)
    
    create(:address)
    create(:address, city: 'Воронеж', name: 'Мебельвуд')
  end

  scenario 'создание компании' do
    visit admin_path
    click_link 'Управление компаниями'
    expect(page).to have_content('Список зарегистрированных компаний')
    click_link 'Добавить компанию'
    fill_in 'Название', with: 'ООО Вектор'
    select 'Москва, Московский проспект, 32а', from: 'company[sections_attributes][0][address_id]'
    fill_in 'Номер секции', with: '12B'
    click_button 'Создать компанию'
    expect(page).to have_content("Компания ООО Вектор успешно создана")
  end
  
  scenario 'редактирование сведений компании' do
    @company = create(:company_with_address)
    visit admin_path
    click_link 'Управление компаниями'
    expect(page).to have_content("#{@company.name}")
    address = Address.last
    expect(address.name).to eq('Мебель-сити')
    section = Section.last
    expect(section).not_to eq(nil)
    expect(section.company_id).to eq(@company.id)
    expect(section.address_id).to eq(address.id)
    click_link 'Редактировать'
  end
  
  



end
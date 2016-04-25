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
    expect {
      fill_in 'Название', with: 'ООО Вектор'
      select 'Москва, Московский проспект, 32а', from: 'company[sections_attributes][0][address_id]'
      fill_in 'Номер секции', with: '12B'
      click_button 'Создать компанию'
    }.to change(Company, :count).by(1)
    expect(page).to have_content('Компания ООО Вектор успешно создана')
    company = Company.last
    expect(page.current_path).to eq(company_path(company))
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
    fill_in 'Название', with: 'ООО Супертел'
    fill_in 'Номер секции', with: '553'
    click_button 'Обновить данные'
    expect(page).to have_content 'Сведения о компании ООО Супертел успешно обновлены'
    expect(page).to have_content 'ООО Супертел'
  end

  scenario 'удаление компании' do
    @company = create(:company_with_address)
    section = Section.last
    expect(section).not_to eq(nil)
    expect(section.company_id).to eq(@company.id)
    visit companies_path
    expect {
      link = "//a[contains(@href, '/companies/#{@company.id}') and .//text()='Удалить']"
      find(:xpath, link).click
    }.to change(Company, :count).by(-1)
    section = Section.last
    expect(section).to eq(nil)
    expect(page).to have_content "Компания #{@company.name} была успешно удалена"
  end

  scenario 'страница компании должна иметь следующие элементы' do
    company = create(:company_with_address, name: 'JSC Acme')
    seller = create(:user, :seller, company: company)
    expect(seller.company_id).to eq(company.id)
    section = company.get_section_at_address(Address.last)



  end

end
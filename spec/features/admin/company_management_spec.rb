require 'rails_helper'

feature 'Управление компаниями' do

  before :each do
    @admin = create(:user, :admin)
    @mall = create(:mall)
    login_as(@admin)
    
  end

  scenario 'создание компании' do
    visit admin_path
    click_link 'Управление компаниями'
    expect(page).to have_content('Список зарегистрированных компаний')
    click_link 'Добавить компанию'
    expect {
      fill_in 'Название', with: 'ООО Вектор'
      fill_in 'Email', with: 'vector@vector.com'
      fill_in 'Телефон', with: 2445665
      fill_in 'О компании', with: 'Самая лучшая компания в мире'
      click_button 'Создать компанию'
    }.to change(Company, :count).by(1)
    expect(page).to have_content('Компания ООО Вектор успешно создана')
    expect(page).to have_content('244-56-65')
    expect(page).to have_content('vector@vector.com')
    expect(page).to have_content('Самая лучшая')
    company = Company.last
    expect(page.current_path).to eq(company_path(company))

  end
  
  scenario 'редактирование сведений компании' do
    @company = create(:company)
    visit admin_path
    click_link 'Управление компаниями'
    expect(page).to have_content("#{@company.name}")
    link = "a[href='/companies/#{@company.id}/edit']"
    find(link).click
    fill_in 'Название', with: 'ООО Супертел'
    fill_in 'О компании', with: 'Telecom company #1'
    fill_in 'Email', with: 'st@st.com'
    fill_in 'Телефон', with: '5552299'
    fill_in 'Примечания', with: 'Контакты центрального офиса'
    click_button 'Обновить данные'
    expect(page).to have_content 'Сведения о компании ООО Супертел успешно обновлены'
    expect(page).to have_content '555-22-99'
    expect(page).to have_content 'ООО Супертел'
    expect(page).to have_content 'Контакты центрального офиса'
    expect(page).to have_content 'Telecom company #1'
    
  end

  scenario 'удаление компании' do
    # @company = create(:company_with_address)
    # section = Section.last
    # expect(section).not_to eq(nil)
    # expect(section.company_id).to eq(@company.id)
    # visit companies_path
    # expect {
    #   link = "//a[contains(@href, '/companies/#{@company.id}') and .//text()='Удалить']"
    #   find(:xpath, link).click
    # }.to change(Company, :count).by(-1)
    # section = Section.last
    # expect(section).to eq(nil)
    # expect(page).to have_content "Компания #{@company.name} была успешно удалена"
  end

  scenario 'страница компании должна иметь следующие элементы' do
    # #создаём компанию и берём созданный с ней адрес
    # company = create(:company_with_address, name: 'JSC Acme')
    # address = company.addresses.last
    # #создаём двух продавцов представляющих эту компанию
    # seller = create(:user, :seller, company: company)
    # seller2 = create(:user, :seller, company: company)
    # #проверка принадлежности продавцов
    # expect(seller.company_id).to eq(company.id)
    # expect(seller2.company_id).to eq(company.id)
    # #проверка принадлежности секции по данному адресу
    # section = Section.last
    # expect(section.company_id).to eq(company.id)
    # expect(section.address_id).to eq(address.id)
    # #создаём второй адрес и секцию по этому адресу
    # address2 = create(:address)
    # section2 = Section.new(company_id: company.id, address_id: address2.id)
    # section2.save
    # #проверяем принадлежность
    # expect(section2.company_id).to eq(company.id)
    # expect(section2.address_id).to eq(address2.id)
    #
    # visit company_path(company)
    # expect(page).to have_content(address.full_address)
    # expect(page).to have_content(address2.full_address)
    # expect(page).to have_content(seller.full_name)
    # expect(page).to have_content(seller2.full_name)
  end
  
  scenario 'селлер добавляет к существующей компании новый адрес' do
    # company = create(:company_with_address, name: 'JSC Acme')
    # visit company_path(company)
    # within('li.list-group-item#add_address') do
    #   expect(page).to have_link('Добавить адрес')
    # end
  end
  

end
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
    @company = create(:company)
    visit companies_path
    expect {
      page.click_link('', href: "/companies/#{@company.id}")
    }.to change(Company, :count).by(-1)
    expect(page.current_path).to eq(companies_path)
    expect(page).to have_content "Компания #{@company.name} была успешно удалена"
  end

  scenario 'страница компании должна иметь следующие элементы' do
    #создаём компанию и берём созданный с ней адрес
    company = create(:company, name: 'JSC Acme')
    #создаём двух продавцов представляющих эту компанию
    seller = create(:user, :seller, company: company)
    seller2 = create(:user, :seller, company: company)
    #проверка принадлежности продавцов
    expect(seller.company_id).to eq(company.id)
    expect(seller2.company_id).to eq(company.id)
    #проверка принадлежности секции по данному адресу
    # section = Section.last
    # expect(section.company_id).to eq(company.id)
    # expect(section.address_id).to eq(address.id)
    #создаём второй адрес и секцию по этому адресу
    
    #проверяем принадлежность
    visit company_path(company)
    
    expect(page).to have_content(seller.full_name)
    expect(page).to have_content(seller2.full_name)
  end
  
  scenario 'селлер добавляет к существующей компании новый адрес' do
    company = create(:company, name: 'JSC Acme')
    visit company_path(company)
    within('li.list-group-item#add_address') do
      expect(page).to have_link('Добавить адрес')
    end
    click_link 'Добавить адрес'
    expect(page.current_path).to eq(new_company_section_path(company.id))
    expect(session[:company_id]).to eq(company_id)
    expect {
      fill_in 'Расположение', with: 'Секция 223'
      click_button 'Добавить адрес'
    }.to change(Section, :count).by(1)
    expect(page.current_path).to eq(company_path(company))
    expect(page).to have_content 'Секция 223'
  end
  

end
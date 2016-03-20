require 'rails_helper'

RSpec.feature "Пользователь" do

  before do
    @john = User.create!(email: "user@example.com", password: "password", first_name: "John",
                         last_name: "Doe")
    @john_product = @john.products.create!(name: "Nice chair", width: 10, depth: 20, height: 40,
                                           description: "Beatiful white chair", color: "White", price: 12990,
                                           category: "Bedroom furniture")
    login_as(@john)
  end

  scenario "вводит корректные новые данные" do
    visit "/"
    click_link "Личный кабинет"
    link = "a[href='/users/#{@john.id}/products/#{@john_product.id}/edit']"
    find(link).click
    fill_in "Стоимость", with: 999
    fill_in "Наименование", with: "Super chair"
    click_button "Сохранить"

    expect(page).to have_content("Сведения о товаре обновлены.")
    expect(page).to have_content(999)
    expect(page).to have_content("Super chair")
    expect(page).not_to have_content("Nice chair")
  end

  scenario "удаляет товар" do
    visit "/"
    click_link "Личный кабинет"
    link = "//a[contains(@href, '/users/#{@john.id}/products/#{@john_product.id}') and .//text()='Удалить'] "
    find(:xpath, link).click
    expect(page).to have_content("Товарная позиция успешно удалена.")
  end


end
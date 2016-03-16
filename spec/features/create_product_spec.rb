require 'rails_helper'
RSpec.feature "Создание продукта" do

  before do
    @john = User.create!(email: "user@example.com", password: "password", first_name: "John",
    last_name: "Doe")
    login_as(@john)
  end

  scenario "Пользователь создаёт продукт" do
    visit "/"
    click_link "Личный кабинет"
    expect(page.current_path).to eq(user_products_path(@john))
    expect(page).to have_content("Мои продукты")
    click_link "Добавить товар"
    select 'Кухонная мебель', from: 'product[product_category]'
    fill_in "Наименование", with: "Кухонный стул"
    fill_in "Ширина", with: 50
    fill_in "Глубина", with: 60
    fill_in "Высота", with: 100
    select "Белый", from: 'product_color'
    fill_in "Стоимость", with: 1490.00
    fill_in "Описание", with: "Прекрасный кухонный стул из шведской сосны"
    click_button "Создать товарную позицию"
    expect(page).to have_content "Товарная позиция успешно создана"
    product = Product.last
    expect(page.current_path).to eq(user_product_path(@john, product))
  end

end
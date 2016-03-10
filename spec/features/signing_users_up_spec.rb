require 'rails_helper'

RSpec.feature "пользователь регистрируется" do

  scenario "с корректными данными" do
    visit "/"
    click_link "Регистрация"
    fill_in "Имя", with: "John"
    fill_in "Фамилия", with: "Doe"
    fill_in "E-mail", with: "user@example.com"
    fill_in "Пароль", with: "password"
    fill_in "Подтверждение пароля", with: "password"
    click_button "Создать аккаунт"
    expect(page).to have_content("Добро пожаловать! Вы успешно зарегистрировались.")

    visit "/"
    expect(page).to have_content("John")
  end

  scenario "с некорректными данными" do
    visit "/"
    click_link "Регистрация"
    fill_in "Имя", with: ""
    fill_in "Фамилия", with: ""
    fill_in "E-mail", with: "user@example.com"
    fill_in "Пароль", with: "password"
    fill_in "Подтверждение пароля", with: "password"
    click_button "Создать аккаунт"
    expect(page).to have_content("First name не может быть пустым")
    expect(page).to have_content("Last name не может быть пусты")

    visit "/"

  end

end
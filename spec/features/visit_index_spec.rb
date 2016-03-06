require 'rails_helper'

RSpec.feature "Visist landing page" do
  scenario do
    visit "/"
    expect(page).to have_content("Поиск мебели")
    expect(page).to have_content("Войти")
  end
end
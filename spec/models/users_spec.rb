require 'rails_helper'

describe User do

  before :each do
    @user = build(:user)
  end

  it 'Созданный пользователь должен проходить валидацию' do
    expect(@user).to be_valid
  end

  it 'По умолчанию создаётся пользователь с ролью user' do
    expect(@user.role).to eq('user')
  end

  it 'Возвращает полное имя' do
    @user = build(:user, first_name: 'John', last_name: 'Doe')
    expect(@user.full_name).to eq('John Doe')
  end


end

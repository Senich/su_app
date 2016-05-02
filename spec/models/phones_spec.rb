require 'rails_helper'

RSpec.describe Phone, type: :model do

  it 'должен иметь длину от 7 до 11 символов' do
    expect(build(:phone, number: 123456)).not_to be_valid
    expect(build(:phone, number: 123456789123)).not_to be_valid
    expect(build(:phone, number: 123456789)).to be_valid
  end

end
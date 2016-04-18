require 'rails_helper'

RSpec.describe Address, type: :model do

  it 'Адрес должен иметь город' do
    expect(build(:address, city: nil)).not_to be_valid
  end

  it 'Адрес должен содержать улицу, проспект, перелок и т.д.' do
    expect(build(:address, street: nil, building: nil)).not_to be_valid
  end



end
require 'rails_helper'

describe Driver do
  it 'exists' do
    driver = create(:driver)

    expect(driver).to be_a(Driver)
  end
  it '#generate_api_key' do
    driver = create(:driver)

    expect(driver.api_key).to eq nil

    driver.generate_api_key

    expect(driver.api_key).not_to eq nil
  end
end

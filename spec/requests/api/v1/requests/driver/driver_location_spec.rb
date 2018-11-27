require 'rails_helper'

describe 'Driver' do
  it 'can update its own location' do
    driver = create(:user)
    driver.generate_api_key

    headers = {
      "CONTENT_TYPE": "application/json",
      'X-API-KEY': driver.api_key
    }

    payload = {
      lat: '39.7507834',
      long: '-104.9964355'
    }

    patch "/api/v1/drivers/#{driver.id}/location", headers: headers, params: payload.to_json


    expect(response.status).to eq(204)

    updated_driver = User.find(driver.id)
    expect(updated_driver.lat).to eq('39.7507834')
    expect(updated_driver.long).to eq('-104.9964355')
  end

  it "can't update another driver's location" do
    driver = create(:user)
    driver.generate_api_key

    driver_2 = create(:user)
    driver_2.generate_api_key

    headers = {
      "CONTENT_TYPE": "application/json",
      'X-API-KEY': driver.api_key
    }

    payload = {
      lat: '39.7507834',
      long: '-104.9964355'
    }

    patch "/api/v1/drivers/#{driver_2.id}/location", headers: headers, params: payload.to_json


    expect(response.status).to eq(403)

    updated_driver_2 = User.find(driver_2.id)
    expect(updated_driver_2.lat).to eq('123.123')
    expect(updated_driver_2.long).to eq('-123.123')
  end
end

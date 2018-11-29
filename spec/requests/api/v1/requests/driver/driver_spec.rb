require 'rails_helper'

describe 'Driver' do

  it 'can get their destination' do
    driver = create(:user, role: 'driver')
    driver.generate_api_key

    headers = { "CONTENT_TYPE" => "application/json", "X-API-KEY" => driver.api_key }

    get "/api/v1/drivers/#{driver.id}", headers: headers

    body = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(200)
    expect(body[:data][:attributes][:formatted_destination]).to eq("https://www.google.com/maps/embed/v1/place?key=#{ENV['GOOGLE_MAPS_API_KEY']}&q=1331+17th+Street,+Denver,+CO+80202")
  end

  it "can't access another driver's destination" do
    driver_1 = create(:user, role: 'driver')
    driver_1.generate_api_key
    driver_2 = create(:user, role: 'driver')
    driver_2.generate_api_key

    headers = { "CONTENT_TYPE" => "application/json", "X-API-KEY" => driver_2.api_key }

    get "/api/v1/drivers/#{driver_1.id}", headers: headers

    body = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(403)
    expect(body[:message]).to eq("Unauthorized")
  end

  it "can't update a destination" do
    driver_1 = create(:user, role: 'driver')
    driver_1.generate_api_key

    new_destination = '6219 Willow Lane, Boulder, CO 80301'
    headers = { "CONTENT_TYPE" => "application/json", "X-API-KEY" => driver_1.api_key }
    payload = {
      destination: new_destination
    }

    post "/api/v1/drivers/#{driver_1.id}/destination", headers: headers, params: payload.to_json

    body = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(403)
    expect(body[:message]).to eq("Unathorized")
  end

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

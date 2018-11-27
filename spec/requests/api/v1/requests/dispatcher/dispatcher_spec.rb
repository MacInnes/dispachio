require 'rails_helper'

describe 'Dispatcher' do
  it "can get a driver's destination and location" do
    driver = create(:user, role: 'driver')
    dispatcher = create(:user, role: 'dispatcher')
    driver.generate_api_key
    dispatcher.generate_api_key

    headers = { "CONTENT_TYPE": "application/json", "X-API-KEY": dispatcher.api_key }

    get "/api/v1/drivers/#{driver.id}", headers: headers

    body = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(200)
    expect(body[:data][:attributes][:formatted_destination]).to eq("https://www.google.com/maps/embed/v1/place?key=#{ENV['GOOGLE_MAPS_API_KEY']}&q=1331+17th+Street,+Denver,+CO+80202")
    expect(body[:data][:attributes][:lat]).to eq("123.123")
    expect(body[:data][:attributes][:long]).to eq("-123.123")
  end

  it "can update a driver's destination" do
    driver = create(:user, role: 'driver')
    dispatcher = create(:user, role: 'dispatcher')
    driver.generate_api_key
    dispatcher.generate_api_key

    headers = { "CONTENT_TYPE" => "application/json", "X-API-KEY" => dispatcher.api_key }

    expect(driver.destination).to eq('1331 17th Street, Denver, CO 80202')

    new_destination = '6219 Willow Lane, Boulder, CO 80301'

    payload = {
      destination: new_destination
    }

    post "/api/v1/drivers/#{driver.id}/destination", headers: headers, params: payload.to_json

    post_body = JSON.parse(response.body, symbolize_names: true)
    expect(response.status).to eq(200)

    driver_headers = { "CONTENT_TYPE" => "application/json", "X-API-KEY" => driver.api_key }

    get "/api/v1/drivers/#{driver.id}", headers: driver_headers
    body = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(200)
    expect(body[:data][:attributes][:destination]).to eq(new_destination)
  end

  it "can update it's own destination" do
    dispatcher = create(:user, role: 'dispatcher')
    dispatcher.generate_api_key

    headers = { "CONTENT_TYPE" => "application/json", "X-API-KEY" => dispatcher.api_key }

    expect(dispatcher.destination).to eq('1331 17th Street, Denver, CO 80202')

    new_destination = '6219 Willow Lane, Boulder, CO 80301'

    payload = {
      destination: new_destination
    }

    post "/api/v1/dispatchers/#{dispatcher.id}/destination", headers: headers, params: payload.to_json

    post_body = JSON.parse(response.body, symbolize_names: true)
    expect(response.status).to eq(200)
    expect(post_body[:data][:attributes][:destination]).to eq(new_destination)
    expect(post_body[:data][:attributes][:formatted_destination]).to eq('https://www.google.com/maps/embed/v1/place?key=AIzaSyAiizvH0vBVQRC1ChK3ga34oGcTiFcWAx0&q=6219+Willow+Lane,+Boulder,+CO+80301')
  end

  it 'can get a list of drivers' do
    dispatcher = create(:user, role: 'dispatcher')
    dispatcher.generate_api_key
    drivers = create_list(:user, 3)

    headers = { "CONTENT_TYPE" => "application/json", "X-API-KEY" => dispatcher.api_key }

    get '/api/v1/drivers', headers: headers

    response_array = JSON.parse(response.body)
    response_body = response_array.map do |each|
      JSON.parse(each, symbolize_names: true)
    end

    expect(response.status).to eq(200)
    expect(response_body.length).to eq(3)
    expect(response_body.first[:data][:type]).to eq('driver')
  end
end

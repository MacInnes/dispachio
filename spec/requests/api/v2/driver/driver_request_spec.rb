require 'rails_helper'

describe '/api/v2/' do

  it 'responds to POST /drivers' do
    username = 'MacInnes'
    payload = {
      username: username,
      password: 'asdf',
      email: 'asdf@asdf.com'
    }

    post '/api/v2/drivers', params: payload

    expect(response.status).to eq(200)
    expect(Driver.find_by_username(username)).not_to eq(nil)
    expect(Driver.find_by_username(username).username).to eq(username)
  end

  it 'fails an invalid POST to /drivers' do
    username = 'sdfkhfd'

    payload = {
      username: username
    }

    post '/api/v2/drivers', params: payload

    body = JSON.parse(response.body, symbolize_names: true)
    expect(response.status).to eq(400)
    expect(body[:message]).to eq('Invalid request')
  end

  it 'responds to GET /drivers/:id' do
    driver = create(:driver)
    driver.generate_api_key

    headers = {
      'X-API-KEY': driver.api_key
    }

    get "/api/v2/drivers/#{driver.id}", headers: headers

    body = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(200)
    expect(body[:data][:type]).to eq('driver')
    expect(body[:data][:attributes][:formatted_destination]).to eq("https://www.google.com/maps/embed/v1/place?key=#{ENV['GOOGLE_MAPS_API_KEY']}&q=1331+17th+Street,+Denver,+CO+80202")
    expect(body[:data][:attributes][:formatted_location]).to eq(driver.lat + ',+' + driver.long)
  end

  it 'responds to POST /drivers/:id/update_location' do
    driver = create(:driver)
    driver.generate_api_key
    new_lat = '40.7128'
    new_long = '74.0060'
    payload = {
      lat: new_lat,
      long: new_long
    }

    headers = {
      'X-API-KEY': driver.api_key
    }

    post "/api/v2/drivers/#{driver.id}/update_location", headers: headers, params: payload

    expect(response.status).to eq(204)
    updated_driver = Driver.find(driver.id)
    expect(updated_driver.lat).to eq(new_lat)
    expect(updated_driver.long).to eq(new_long)
  end
end

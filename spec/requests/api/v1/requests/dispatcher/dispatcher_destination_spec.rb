require 'rails_helper'

describe 'Dispatcher' do
  it "can get a driver's destination" do
    driver = create(:user, role: 'driver')
    dispatcher = create(:user, role: 'dispatcher')
    driver.generate_api_key
    dispatcher.generate_api_key

    headers = { "CONTENT_TYPE" => "application/json", "X-API-KEY" => dispatcher.api_key }

    get "/api/v1/drivers/#{driver.id}/destination", headers: headers

    body = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(200)
    expect(body[:data][:attributes][:formatted_destination]).to eq("https://www.google.com/maps/embed/v1/place?key=#{ENV['GOOGLE_MAPS_API_KEY']}&q=1331+17th+Street,+Denver,+CO+80202")
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

    get "/api/v1/drivers/#{driver.id}/destination", headers: driver_headers
    body = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(200)
    expect(body[:data][:attributes][:destination]).to eq(new_destination)
  end
end

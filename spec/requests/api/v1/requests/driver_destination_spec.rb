require 'rails_helper'

describe 'Driver' do
  it 'can get their destination' do
    driver = create(:user, role: 'driver', destination: '1331 17th St, Denver, CO, 80202')
    driver.generate_api_key

    headers = { "CONTENT_TYPE" => "application/json", "X-API-KEY" => driver.api_key }

    get "/api/v1/drivers/#{driver.id}/destination", headers: headers

    body = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(200)
    expect(body[:data][:attributes][:formatted_destination]).to eq("https://www.google.com/maps/embed/v1/place?key=#{ENV['GOOGLE_MAPS_API_KEY']}&q=1331+17th+St,+Denver,+CO,+80202")
  end

  it "can't access another driver's destination" do
    driver_1 = create(:user, role: 'driver', destination: '1331 17th St, Denver, CO, 80202')
    driver_1.generate_api_key
    driver_2 = create(:user, role: 'driver', destination: '6219 Willow Lane, Boulder, CO, 80301')
    driver_2.generate_api_key

    headers = { "CONTENT_TYPE" => "application/json", "X-API-KEY" => driver_2.api_key }

    get "/api/v1/drivers/#{driver_1.id}/destination", headers: headers

    body = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(403)
    expect(body[:message]).to eq("Unauthorized")
  end
end

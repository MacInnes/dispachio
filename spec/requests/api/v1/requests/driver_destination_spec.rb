require 'rails_helper'

describe 'Driver' do
  it 'can get their destination' do
    driver = create(:user, role: 'driver', destination: '1331 17th St, Denver, CO, 80202')
    driver.generate_api_key

    headers = { "CONTENT_TYPE" => "application/json", "X-API-KEY" => driver.api_key }

    get "/api/v1/drivers/#{driver.id}/destination", headers: headers

    body = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(200)
    expect(body[:data][:attributes][:formatted_destination]).to eq('1331+17th+St,+Denver,+CO,+80202')
  end
end

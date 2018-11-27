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

    post "/api/v1/drivers/#{driver.id}/location", headers: headers, params: payload.to_json

    binding.pry
    expect(response.status).to eq(204)

  end
end

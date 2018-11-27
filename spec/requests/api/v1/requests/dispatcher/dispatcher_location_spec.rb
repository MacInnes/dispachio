require 'rails_helper'

describe 'Dispatcher' do
  it "can get a driver's location" do
    driver = create(:user)
    dispatcher = create(:user, role: 'dispatcher')
    driver.generate_api_key
    dispatcher.generate_api_key

    headers = {
      "CONTENT_TYPE": "application/json",
      'X-API-KEY': dispatcher.api_key
    }

    get "/api/v1/drivers/#{driver.id}/location", headers: headers

    binding.pry
    response_body = JSON.parse(response.body, symbolize_names: true)
    expect(response.status).to eq(200)
  end
end

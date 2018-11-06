require 'rails_helper'

describe User do
  it 'has attributes' do
    user = create(:user)

    expect(user.username).to eq('MacInnes')
    expect(user.email).to eq('test@test.com')
    expect(user.role).to eq('dispatcher')
  end
  it '#generate_api_key' do
    user = create(:user)

    expect(user.api_key).to eq nil

    user.generate_api_key

    expect(user.api_key).not_to eq nil
  end
  it '#formatted_destination' do
    user = create(:user, destination: '1331 17th Street, Denver, CO, 80202')

    expect(user.formatted_destination).to eq("https://www.google.com/maps/embed/v1/place?key=#{ENV['GOOGLE_MAPS_API_KEY']}&q=1331+17th+Street,+Denver,+CO,+80202")
  end
end

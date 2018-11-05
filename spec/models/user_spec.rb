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
end

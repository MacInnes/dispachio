require 'rails_helper'

describe 'User registration' do
  it 'can register a new user' do
    username = 'MacInnes'

    payload = {
      username: username,
      email: 'test@test.com',
      password: 'asdf',
      role: 'dispatcher'
    }

    post '/api/v1/users', params: payload

    expect(User.find_by_username(username)).not_to eq(nil)
    expect(User.find_by_username(username).username).to eq(username)
  end

  it "can't create a new user with bad data" do
    username = 'MacInnes'

    payload = {
      username: username,
      role: 'dispatcher'
    }

    post '/api/v1/users', params: payload

    body = JSON.parse(response.body, symbolize_names: true)
    expect(response.status).to eq(400)
    expect(User.find_by_username(username)).to eq(nil)
    expect(body[:message]).to eq("Invalid request")
  end
end

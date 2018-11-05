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
end

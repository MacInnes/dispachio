require 'rails_helper'

describe '/api/v2/' do
  it 'responds to POST /drivers' do
    username = 'MacInnes'
    payload = {
      username: username,
      password: 'asdf',
      email: 'asdf@asdf.com'
    }

    post '/api/v2/dispatchers', params: payload

    expect(response.status).to eq(200)
    
    dispatcher = Dispatcher.find_by_username(username)
    expect(dispatcher).not_to eq(nil)
    expect(dispatcher.username).to eq(username)
  end
end

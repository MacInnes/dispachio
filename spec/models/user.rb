require 'rails_helper'

describe User do
  it 'has attributes' do
    user = create(:user)

    expect(user.username).to eq('MacInnes')
    expect(user.email).to eq('test@test.com')
    expect(user.role).to eq('dispatcher')
  end
end

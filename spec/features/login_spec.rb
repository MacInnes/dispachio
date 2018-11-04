require 'rails_helper'

feature 'An unregistered user' do
  scenario 'can create an account' do
    # As an unregistered user, I can visit root and see a link to register.
    visit '/'

    expect(page).to have_content('Register')

    click_on('Register')

    expect(current_path).to eq('/register')

    fill_in :username, with: 'MacInnes'
    fill_in :email, with: 'test@test.com'
    fill_in :password, with: 'password'
    select :Dispatch, from: :role
    click_on('Submit')

    expect(current_path).to eq('/dispatch')
    expect(page).to have_content('Logged in as MacInnes')

    # I receive an email including my API key.
  end
end

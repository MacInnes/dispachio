require 'rails_helper'

feature 'An unregistered user' do
  scenario 'can create a dispatcher account' do
    # As an unregistered user, I can visit root and see a link to register.
    visit '/'

    expect(page).to have_content('Register')

    click_on('Register')

    expect(current_path).to eq('/register')

    fill_in :user_username, with: 'MacInnes'
    fill_in :user_email, with: 'test@test.com'
    fill_in :user_password, with: 'password'
    select :dispatcher, from: :user_role
    click_on('Submit')

    expect(current_path).to eq('/dispatcher')
    expect(page).to have_content('Logged in as MacInnes')

    # I receive an email including my API key.
  end

  scenario 'can create a driver account' do
    visit '/'

    expect(page).to have_content('Register')

    click_on('Register')

    expect(current_path).to eq('/register')

    fill_in :user_username, with: 'MacInnes'
    fill_in :user_email, with: 'test@test.com'
    fill_in :user_password, with: 'password'
    select :driver, from: :user_role
    click_on('Submit')

    expect(current_path).to eq('/driver')
    expect(page).to have_content('Logged in as MacInnes')
  end
end

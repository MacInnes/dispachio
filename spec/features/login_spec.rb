require 'rails_helper'

feature 'An unregistered user' do
  scenario 'can create a dispatcher account' do
    # As an unregistered user, I can visit root and see a link to register.
    visit '/'

    expect(page).to have_content('Register')

    click_on('Register')

    expect(current_path).to eq('/register')

    fill_in :username, with: 'MacInnes'
    fill_in :email, with: 'test@test.com'
    fill_in :password, with: 'password'
    choose :role, option: "dispatcher"
    click_on('Submit')

    expect(current_path).to eq("/dispatcher/1")
    expect(page).to have_content('Logged in as MacInnes')

    # I receive an email including my API key.
  end

  scenario 'can create a driver account' do
    visit '/'

    expect(page).to have_content('Register')

    click_on('Register')

    expect(current_path).to eq('/register')

    fill_in :username, with: 'MacInnes'
    fill_in :email, with: 'test@test.com'
    fill_in :password, with: 'password'
    choose :role, option: "driver"
    click_on('Submit')

    expect(current_path).to eq('/driver/1')
    expect(page).to have_content('Logged in as MacInnes')
  end

  scenario 'creates an invalid account' do
    visit '/register'

    fill_in :username, with: 'MacInnes'
    choose :role, option: "driver"
    click_on('Submit')

    expect(current_path).to eq('/register')
    expect(page).to have_content('Invalid registration details.')
  end
end

require 'rails_helper'

RSpec.describe 'Profile' do
  let!(:user) { create :user, password: 'doomdoom', password_confirmation: 'doomdoom' }
  let!(:person) { create :person, user: user }

  before :each do
    user.confirm!
    user.save!

    visit '/'
    click_on 'Log in'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'doomdoom'
    find_button('Log in').click
    click_on 'Dashboard'
    expect(page).to have_text person.name
  end

  describe 'Edit profile' do
    before :each do
      click_on('Edit Profile')
      expect(page).to have_text 'Edit User'
    end

    it 'can change password' do
      fill_in 'Password', with: 'goomgoom'
      fill_in 'Password confirmation', with: 'goomgoom'
      fill_in 'Current password', with: 'doomdoom'
      find_button('Update').click
      expect(page).to have_text 'successfully'
    end

    it 'can adjust privacy settings' do
      check('Hide Email')
      check('Hide Address')
      check('Hide Phone')
      check('Hide Persona')
      fill_in 'Current password', with: 'doomdoom'
      find_button('Update').click
      expect(page).to have_text 'successfully'
      expect(person.reload.private_email).to be_truthy
    end
  end
end

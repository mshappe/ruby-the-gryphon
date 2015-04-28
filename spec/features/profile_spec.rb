require 'rails_helper'

RSpec.describe 'Profile' do
  let!(:user) { create :user, password: 'doomdoom', password_confirmation: 'doomdoom' }
  let!(:person) { create :person, user: user }

  before :each do
    user.confirm!
    user.save!

    visit '/'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'doomdoom'
    find_button('Log in').click
  end

  describe 'Edit profile' do
    before :each do
      find_link('Edit Profile', match: :first).click
      expect(page).to have_text 'Edit User'
    end

    it 'can change password' do
      fill_in 'Password', with: 'goomgoom'
      fill_in 'Password confirmation', with: 'goomgoom'
      fill_in 'Current password', with: 'doomdoom'
      find_button('Update').click
    end

    it 'can adjust privacy settings' do
      check('Hide Email')
      check('Hide Address')
      check('Hide Phone')
      check('Hide Persona')
    end
  end
end
require 'rails_helper'

RSpec.describe 'Persona stuff', type: :feature do
  let!(:user) { create :user, password: 'doomdoom', password_confirmation: 'doomdoom' }
  let!(:person) { create :person, user: user }
  let(:persona) { create :persona, user: user }

  before :each do
    user.confirm!
    user.save!

    visit '/'
    fill_in 'Email', with: persona.user.email
    fill_in 'Password', with: 'doomdoom'
    find_button('Log in').click
  end

  describe 'editing' do
    before :each do
      visit "/personas/#{persona.id}/edit"
    end

    it 'should safely edit description' do
      expect(page).to have_text "Edit #{persona.name}"
      fill_in 'Description', with: 'I am a wombat'
      find_button('Save').click
      expect(page).to have_text 'was successfully updated'
    end

    it 'should safely delete' do
      find_link('Delete').click
      expect(page).to have_text 'was successfully destroyed'
    end
  end

  describe 'show' do
    before :each do
      visit "/personas/#{persona.id}"
    end

    it 'should show description' do
      expect(page).to have_text persona.name
      expect(page).to have_text persona.description

      # We're logged in so we should also see personal info
      expect(page).to have_text persona.person.name
    end
  end

end
require 'rails_helper'

RSpec.describe 'Unsaved Changes', type: :feature, js: true do
  before :each do
    visit '/'
    fill_in 'Email', with: 'abcdef'
  end

  it 'should navigate away with unsaved changes on accept' do
    accept_confirm do
      click_link 'Forgot your password?'
    end

    expect(page).to have_button 'Forgot my password'
  end

  it 'should not navigate away on reject' do
    dismiss_confirm do
      click_link 'Forgot your password?'
    end

    expect(page).not_to have_button 'Forgot my password'
  end
end
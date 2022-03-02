require 'rails_helper'

describe 'Login process', type: :feature do
  context 'Elements on page display' do
    it 'Login form shows elements correct' do
      visit '/users/sign_in'
      expect(page).to have_content('Email')
    end
  end
end
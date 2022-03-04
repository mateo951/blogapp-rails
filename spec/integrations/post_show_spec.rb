require 'rails_helper'
require './spec/integrations/registration_mocks'

RSpec.describe 'user index view', type: :feature do
  include Mocks
  before :each do
    @users = create_users
    @posts = create_posts(@users)
    visit new_user_session_path

    within('form') do
      fill_in 'user_email', with: 'foo1@foo.com'
      fill_in 'user_password', with: 'admin123'
    end
    click_button 'Log in'
  end

  context 'Elements on page display' do
    it 'All user names are displayed' do
      users = User.all
      users.each do |user|
        expect(page).to have_content(user.name)
      end
    end
    it 'All user photos are displayed' do
      users = User.all.order(:id)
      imgs = page.all('img')
      users.each_with_index do |_user, index|
        expect(imgs[index]['src']).to include('')
      end
      expect(imgs.length).to equal(users.length)
    end
    it 'User posts number is displayed' do
      users = User.all
      users.each do |user|
        expect(page).to have_content "Posts: #{user.post_counter}"
      end
    end
  end
  context 'User interacton of profile' do
    it "Redirected to user's show page" do
      expect(page).to have_content 'Profile'
      click_link('Profile', match: :first)
      expect(page).to have_content "I'm the last oracle"
    end
  end
end

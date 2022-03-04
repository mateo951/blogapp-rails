require 'rails_helper'
require './spec/integrations/registration_mocks'

RSpec.describe 'user show view', type: :feature do
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
    click_link('Profile', match: :first)
  end

  context 'Elements on page show' do
    it 'User photo is displayed' do
      imgs = page.all('img')
      expect(imgs[0]['alt']).to include('User Image')
    end

    it 'Should display User\'s name' do
      expect(page).to have_content(@users.first.name)
    end

    it 'Should display number of posts by its user' do
      expect(page).to have_content "Posts: #{@users.first.post_counter}"
    end

    it 'Should display user\'s bio' do
      expect(page).to have_content 'I\'m the last oracle'
    end

    it 'Should display user\'s three posts' do
      expect(page).to have_link('Read post', count: 3)
    end

    it 'Should display See all post button' do
      expect(page).to have_content 'See all post'
    end
  end

  context 'User interaction of profile' do
    it 'Redirect to full post page' do
      click_link('Read post', match: :first)
      expect(page).to have_content 'Write a new comment'
    end

    it 'Redirected to post\'s index page' do
      click_link('See all posts')
      expect(page).to have_content 'pagination'
    end
  end
end
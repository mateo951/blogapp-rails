require 'rails_helper'
require './spec/integrations/integration_mocks'

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
    it 'The user photo is displayed' do
      imgs = page.all('img')
      expect(imgs[0]['src']).to include(@users[0].name)
    end

    it 'Should display User\'s name' do
      expect(page).to have_content(@users.first.name)
    end

    it 'Should display number of posts by its user' do
      expect(page).to have_content "Number of posts: #{@users.first.posts_counter}"
    end

    it 'Should display user\'s bio' do
      expect(page).to have_content 'I\'m the last oracle'
    end

    it 'Should display user\'s three posts' do
      expect(page).to have_link('Full post', count: 5)
    end

    it 'Should display See all post button' do
      expect(page).to have_content 'See all post'
    end
  end

  context 'User interaction of profile' do
    it 'Redirect to full post page' do
      click_link('Full post', match: :first)
      expect(page).to have_content 'Create Comment'
    end
  end
  context 'Redirecting properly to other paths' do
    it "When I click a user's post, it redirects me to that post's show page" do
      post = @users[0].recent_posts[0]
      click_link('Full post', match: :first)
      expect(page).to have_current_path "/users/#{@users[0].id}/posts/#{post.id}"
    end

    it "When I click to see all posts, it redirects me to the user's post's index page" do
      click_link('See all post')
      expect(page).to have_current_path "/users/#{@users[0].id}/posts"
    end
  end
end

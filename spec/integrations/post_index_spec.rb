require 'rails_helper'
require './spec/integrations/integration_mocks'

RSpec.describe 'user index view', type: :feature do
  include Mocks
  before :each do
    @users = create_users
    @posts = create_posts(@users)
    @post = @users[0].recent_posts[0]
    create_likes_comments(@users, @posts)
    visit new_user_session_path

    within('form') do
      fill_in 'user_email', with: 'foo1@foo.com'
      fill_in 'user_password', with: 'admin123'
    end
    click_button 'Log in'
    click_link('Profile', match: :first)
  end
  context 'displaying user info' do
    it 'user image is displayed' do
      expect(page).to have_selector('img')
    end
    it 'user name is displayed' do
      expect(page).to have_content(@users[0].name)
    end
    it 'user number of post is displayed' do
      expect(page).to have_content "Number of posts: #{@users[0].posts_counter}"
    end
  end
  context 'displaying post info' do
    it "can see post's title" do
      posts = Post.all.where(author_id: 1)
      posts.each do |post|
        expect(page).to have_content post.title
      end
    end
    it "can see post's text" do
      expect(page).to have_content 'This is post number'
    end
  end
  context 'displaying comments info' do
    it 'can see recents comment' do
      @post.recent_comments do |comment|
        expect(page).to have_content comment.text
      end
    end
    it 'can see comments counter' do
      expect(page).to have_content "Comments: #{@post.comments_counter}"
    end
    it 'can see likes counter' do
      expect(page).to have_content "Likes:#{@post.likes_counter}"
    end
  end
  context 'redirecting properly to other paths' do
    it "When I click a user's post, it redirects me to that post's show page" do
      post = @users[0].recent_posts[0]
      click_link("Full post", match: :first)
      expect(page).to have_current_path "/users/#{@users[0].id}/posts/#{post.id}"
    end
  end
end
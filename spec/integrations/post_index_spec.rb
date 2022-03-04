require 'rails_helper'
require './spec/integrations/registration_mocks'

RSpec.describe 'Post index view', type: :feature do
  include Mocks
  before :each do
    @users = create_users
    @posts = create_posts(@users)
    @likes, @comments = create_likes_comments(@users, @posts)
    visit new_user_session_path
    within('form') do
      fill_in 'user_email', with: 'foo1@foo.com'
      fill_in 'user_password', with: 'admin123'
    end
    click_button 'Log in'
    click_link('Profile', match: :first)
    click_link('See all posts')
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

    it 'I can see a post\'s title' do
      post = Post.all.where(user_id: 1)
      post.each do |t|
        expect(page).to have_content t.title
      end
    end

    it 'I can see some of the post\'s body' do
      post = Post.all.where(user_id: 1)
      post.each do |t|
        expect(page).to have_content t.title
      end
    end
  end

  context 'Display comments, likes and pagination' do
    it 'I can see some comments on a post' do
      expect(page).to have_link('Delete', count: 5)
    end

    it 'How many comments a post has' do
      expect(page).to have_content('Comments: 2')
    end

    it 'How many likes a post has' do
      expect(page).to have_content('Likes: 2')
    end

    it 'Can see a section for pagination' do
      expect(page).to have_content('pagination')
    end
  end

  context 'User interaction of profile' do
    it 'Click on a post and redirect me to its full page' do
      click_link('Comments', match: :first)
      expect(page).to have_content 'Write a new comment'
    end
  end
end

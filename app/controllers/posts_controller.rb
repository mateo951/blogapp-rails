class PostsController < ApplicationController
  def index
    @user = User.find(params[:id])
    @posts = @user.recent_posts
  end

  def show
    @user = User.find(params[:id])
    @post = @user.posts.find(params[:id])
    @comments = @post.comments.all
  end
end

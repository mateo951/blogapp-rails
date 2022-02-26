class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:post_id])
    @comments = @post.comments.all
    @newPost = Post.new
  end

  def new
    @user = User.find(params[:id])
    @post = Post.new
    respond_to do |format|
      format.html { render :new }
    end
  end

  def create
    @user = User.find(params[:id])
    @post = @user.posts.create(post_params)
    if @post.save
      flash[:success] = 'Post saved successfully'
      Post.update_counter(@user.id)
    else
      flash[:error] = 'Error:  Post could not be saved'
    end
    redirect_to "/users/#{@post.author_id}/posts"
  end

  private

  def post_params
    params.require(:post).permit(:title, :text, :author_id, :comments_counter, :likes_counter)
  end
end

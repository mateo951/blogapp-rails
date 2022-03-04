class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
    render json: { success: true, data: { posts: @posts } }
      # respond_to do |format|
      #   format.html # index.html.erb
      #   format.xml  { render :xml => @posts }
      #   format.json { render :json => @posts }
      # end
      render json: { success: true, data: { posts: @posts } }
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:post_id])
    @comments = @post.comments.all
    render json: { success: true, data: { posts: @comments } }
    # respond_to do |format|
    #   format.html # index.html.erb
    #   format.xml  { render :xml => @comments }
    #   format.json { render :json => @comments }
    # end


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
    redirect_to "/users/#{@post.author_id}"
  end

  def destroy
    @user = User.find(params[:user_id])
    @post = Post.find_by_id(params[:post_id])
    if @post.destroy
      flash[:success] = 'Post deleted successfully!'
    else
      flash[:error] = 'Something went wrong, please try it again!'
    end
    redirect_to "/users/#{@post.author_id}"
  end

  def post_params
    params.require(:post).permit(:title, :text, :author_id, :comments_counter, :likes_counter)
  end
end

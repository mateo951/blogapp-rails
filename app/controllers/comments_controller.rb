class CommentsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def new
    @comment = Comment.new
    respond_to do |format|
      format.html { render :new }
    end
  end

  def create
    @post = Post.find_by_id(params[:post_id])
    @comment = @post.comments.create(comment_params.merge(author_id: current_user.id))
    if @comment.save
      flash[:success] = 'Comment saved successfully'
      redirect_to "/users/#{@post.author_id}/posts/#{@post.id}"
      Comment.update_counter(@post)
    else
      flash[:error] = 'Error: Comment could not be saved'
      redirect_to "/users/#{@post.author_id}/posts/#{@post.id}"
    end
  end

  def destroy
    @post = Post.find_by_id(params[:post_id])
    @user = User.find_by_id(params[:user_id])
    @comment = @post.comments.find(params[:format])
    if @comment.destroy
      flash[:success] = 'Post destroyed successfully'
    else
      flash[:error] = 'Error:  Post could not be destroyed'
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def comment_params
    params.require(:comment).permit(:author_id, :post_id, :text)
  end
end

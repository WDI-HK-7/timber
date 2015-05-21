class PostsController < ApplicationController

  before_action :authenticate_user!

  def index
    @posts = Post.order(created_at: :desc).limit(15).offset(params[:offset])
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      render :json => {message: "saved", post: @post}
    else
      render :json => {message: "not saved"}
    end
  end

  def update
     @post = Post.find_by_id(params[:id])

    if @post.nil?
      render :json => {
        :message => { :message => "Cannot find post", :delete => false }
      }
    else
      if @post.update(post_params)  
        render :json => {message: "updated", post: @post}
      else
        render :json => {message: "not updated"}
      end
    end
  end

  def show
    @post = Post.find_by_id(params[:id])

    if @post.nil?
      render :json => {
        :message => { :message => "Cannot find post" }
      }
    end
  end

  def random
    # binding.pry
    @post = Post.find(Post.where.not(user_id: current_user.id).pluck(:id).sample)

    if @post.nil?
      render :json => { message: "Cannot find post" }
    end

    render :show
  end

  # Returns all the post from a certain user 
  def user_post
    @posts = Post.where(user_id: params[:user_id])

    if @posts.nil?
      render :json => {message: "Cannot find post" }
    end

    render :index
  end

  def destroy
    @post = Post.find_by_id(params[:id])

    if @post.nil?
      render :json => { message: "Cannot find post", :delete => false }
    else
      if @post.destroy
        render :json => { message: "Successful", :delete => true }
      else
        render :json => { message: "Unsuccessful", :delete => false }
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :title, :content, :picture)
  end
end

class PostsController < ApplicationController

  before_action :authenticate_user!

  def index
    # @posts = Post.all
    @posts = Post.order(created_at: :desc).limit(15).offset(params[:offset])

    # .includes(:comments)

  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      render :json => {message: "saved"}
    else
      render :json => {message: "not saved"}

    end
  end

  def update #update a post
     @post = Post.find_by_id(params[:id])

    if @post.nil?
      render :json => {
        :message => { :message => "Cannot find post", :delete => false }
      }
    else
      if @post.update(post_params)  
        render :json => {message: "updated"}
      else
        render :json => {message: "not updated"}
      end
    end
  end

  def show #showone
    @post = Post.find_by_id(params[:id])

    if @post.nil?
      render :json => {
        :message => { :message => "Cannot find post" }
      }
    end
  end

  def random

    # @post = Post.where('id != ?', @post.id).order('RANDOM()').limit(1)
    @post = Post.order('RANDOM()').limit(1)

    if @post.nil?
      render :json => {
        :message => { :message => "Cannot find post" }
      }
    end
  end

  def userpost #find post by user ID
     @post = Post.find_by_id(params[:user_id])

    if @post.nil?
      render :json => {
        :message => { :message => "Cannot find post" }
      }
    end
  end

  def destroy
    @post = Post.find_by_id(params[:id])

    if @post.nil?
      render :json => {
        :message => { :message => "Cannot find post", :delete => false }
      }
    else
      if @post.destroy
        render :json => { :message => { :message => "Successful", :delete => true}
        }
      else
      render :json => { :message => { :message => "Unsuccessful", :delete => false}
      }
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :title, :content, :picture)
  end
end

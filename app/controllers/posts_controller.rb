class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def create
    @post = Post.new(post_params)
    @post.save
  end

  def update
     @post = Post.find_by_id(params[:id])

    if @post.nil?
      render :json => {
        :message => { :message => "Cannot find post", :delete => false }
      }
    else
      @post.update(post_params)
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
    params.require(:post).permit(:title, :content, :picture)
  end
end

class LikesController < ApplicationController

  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    if @post && Like.create(post_id: @post.id, user_id: current_user.id, owner_id: @post.user_id)
      @likes = Like.where(owner_id: current_user.id, user_id: @post.user_id).joins(:post, :user).select("likes.*,users.*,posts.*")
      unless @likes.empty?
        render :json => {message: "match", posts: @likes}
      else
        render :json => {message: "no match"}
      end
    else
      render :json => {message: "error!"}
    end
  end


end

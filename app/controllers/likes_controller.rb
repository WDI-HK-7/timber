class LikesController < ApplicationController
  
  before_action :authenticate_user!

  def create
    if Like.create(post_id: params[:post_id], user_id: current_user.id)
      render :json => {message: "success"}
    else
      render :json => {message: "error!"}
    end
  end

  
end

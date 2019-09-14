class CommentsController < ApplicationController
  before_action :set_user 
   
  def create
    user = User.find(params[:tell_id])
    Comment.create(text: comment_params[:text], tell_id: user.id, user_id: current_user.id)
    redirect_to user_path(user)
  end

  private

  def set_user
    user = User.find(params[:tell_id])
  end
  
  def comment_params
    params.require(:comment).permit(:text)
  end
end

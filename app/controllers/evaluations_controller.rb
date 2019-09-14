class EvaluationsController < ApplicationController
  before_action :set_user 
   
  def create
    user = User.find(params[:rate_id])
    Evaluation.create(value: evaluation_params[:value], rate_id: user.id, user_id: current_user.id)
    redirect_to user_path(user)
  end

  def update
    user = User.find(params[:rate_id])
    Evaluation.update(value: evaluation_params[:value], rate_id: user.id, user_id: current_user.id)
    redirect_to user_path(user)
  end

  private

  def set_user
    user = User.find(params[:rate_id])
  end
  
  def evaluation_params
    params.require(:evaluation).permit(:value)
  end

end

class HavethingsController < ApplicationController
    
    def index 
        @user = User.find(params[:user_id])
        @havethings = @user.havethings.order("created_at DESC").includes(:user)
        @evaluation = Evaluation.new
        @comment = Comment.new
        @comments = @user.reverse_of_comments.order("created_at DESC").includes(:user)
        @amount = Amount.new
        @total_evaluation = 0
        @users = User.all
        @users.each do |user|
             if user.evaluate > 0
                 @total_evaluation += user.evaluate
             end
        end
        @messages = Message.where(talk_id: current_user.id, notification: 0).includes(:user)
    end
    
    def new
        @havething = Havething.new
        @havethings = current_user.havethings.order("created_at DESC").includes(:user)
    end
    
    def create 
        Havething.create(name: havething_params[:name], price: havething_params[:price], image: havething_params[:image], user_id: current_user.id)
        redirect_to new_user_havething_path(current_user)
    end
    
    private
    
    def havething_params
        params.require(:havething).permit(:name, :price, :image)
    end
end

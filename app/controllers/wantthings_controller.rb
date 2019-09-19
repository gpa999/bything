class WantthingsController < ApplicationController
    def index 
        @user = User.find(params[:user_id])
        @wantthings = @user.wantthings.order("created_at DESC")
        @evaluation = Evaluation.new
        @comment = Comment.new
        @comments = @user.reverse_of_comments.order("created_at DESC")
        @amount = Amount.new
        @total_evaluation = 0
        @users = User.all
        @users.each do |user|
             if user.evaluate > 0
                 @total_evaluation += user.evaluate
             end
        end
        @messages = Message.where(talk_id: current_user.id, notification: 0)
    end
    
    def new 
        @wantthing = Wantthing.new 
        @wantthings = current_user.wantthings.order("created_at DESC")
    end
end

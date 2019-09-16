class WantthingsController < ApplicationController
    def index 
        @user = User.find(params[:user_id])
        @wantthings = @user.wantthings.order("created_at DESC")
    end
    
    def new 
        @wantthing = Wantthing.new 
        @wantthings = current_user.wantthings.order("created_at DESC")
    end
end

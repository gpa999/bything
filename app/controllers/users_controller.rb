class UsersController < ApplicationController
    protect_from_forgery except: :image_update
    
    def login_form
    end
    
    def index
        @users = User.search(params[:search])
        @all_users = User.all
    end
    
    def show
        @user = User.find(params[:id])
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
    
    def edit 
    end
    
    def update
        user = User.find(params[:id])
        user.update(update_params)
        redirect_to user_path(user)
    end
    
    def image_update
        current_user.image.purge
        redirect_to edit_user_path(current_user)
    end
    
    def send_messages
        @messages = current_user.reverse_of_messages.order("created_at DESC").includes(:user)
    end
    
    def point_index
        @user = User.find(params[:user_id])
        @issuers = (@user.have_people.all + @user.give_people.all).sort_by {|i| @user.give_take_point(i) }.reverse!
    end
    
    def refuse_create
        @point_confirmation = PointConfirmation.find(params[:con_id])
        @message = Message.new(talk_id: message_params[:talk_id], kind: message_params[:kind],user_id: current_user.id )
        @message.save && @point_confirmation.update(answered: 1)
        redirect_to user_path(current_user)
    end
    def selled_points
        @user = User.find(params[:user_id])
        @nomalpoints = Nomalpoint.all
        @exchangepoint = Exchangepoint.new
    end
    
    private
    
    def update_params
        params.require(:user).permit(:image, :name, :text)
    end
    
    def message_params
        params.require(:message).permit(:talk_id, :kind)
    end
end

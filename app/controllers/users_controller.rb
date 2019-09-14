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
        @comments = @user.reverse_of_comments.order("created_at DESC")
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
    
    private
    
    def update_params
        params.require(:user).permit(:image, :name, :text)
    end
end

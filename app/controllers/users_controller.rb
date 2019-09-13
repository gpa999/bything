class UsersController < ApplicationController
    protect_from_forgery except: :image_update
    
    def login_form
    end
    
    def index
    end
    
    def show
        @user = User.find(params[:id])
    end
    
    def edit 
    end
    
    def update
        User.update(update_params)
        redirect_to user_path(current_user)
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

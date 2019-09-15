class HavethingsController < ApplicationController
    
    def index 
        @user = User.find(params[:user_id])
        @havethings = @user.havethings.order("created_at DESC")
    end
    
    def new
        @havething = Havething.new
        @havethings = current_user.havethings.order("created_at DESC")
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

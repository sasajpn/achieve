class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end
  
  def edit
  end
  
  def update
    current_user.update(update_params)
  end

  
  
  private
  
    def user_params
      params.require(:user).permit(:name, :profile, :image, :remove_image)
    end
    
    def update_params
      params.permit(:user).permit(:name, :profile)
    end
end

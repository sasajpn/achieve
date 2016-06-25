class UsersController < ApplicationController
  def index
    @users = User.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
  end
  
  def edit
  end
  
  def update
    current_user.update(update_params)
  end
  
  def following
    @user = User.find(params[:id])
    @users = @user.followed_users
    render action: 'show_follow'
  end
  
  def followers
    @user = User.find(params[:id])
    @users = @user.followers
    render action: 'show_follow'
  end

  
  
  private
  
    def user_params
      params.require(:user).permit(:name, :profile, :image, :remove_image)
    end
    
    def update_params
      params.permit(:user).permit(:name, :profile)
    end
end

class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  respond_to :html, :js
  
  def create
    @user = User.find(params[:relationship][:followed_id])
    if @user != current_user
      current_user.follow!(@user)
      respond_with @user
    else
      flash[:alert] = "無効なリクエストです。"
      redirect_to users_path
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    if @user != current_user
      current_user.unfollow!(@user)
      respond_with @user
    else
      flash[:alert] = "無効なリクエストです。"
      redirect_to users_path
    end
  end
end

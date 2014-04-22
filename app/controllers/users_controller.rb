class UsersController < ApplicationController

  before_action :get_user, only: [ :update, :destroy ]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(user_params)
    redirect_to :root
  end

  def destroy
    current_user.destroy
    log_user_out_and_redirect(root_url, "You've successfully deleted your account.")
  end

  private

  def user_params
    params.require(:user).permit(:avatar, :id)
  end

end
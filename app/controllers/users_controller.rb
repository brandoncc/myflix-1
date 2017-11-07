class UsersController < ApplicationController
  before_action :require_user, only: [:show]

  def new
    @user = User.new
  end

  def show
    @user = User.find_by(token: params[:id])
    @relationship = Relationship.find_by(follower:current_user, leader: @user)
  end

  def create
    @user = User.new(user_params)

    if @user.save
      MyMailer.register_success_mail(@user).deliver
      redirect_to sign_in_path
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :full_name)
  end
end
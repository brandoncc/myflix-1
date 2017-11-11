class UsersController < ApplicationController
  before_action :require_user, only: [:show]

  def new
    queries = request.query_parameters
    @user = User.new(email: queries[:email], invitor_token: queries[:invitor])
  end

  def show
    @user = User.find_by(token: params[:id])
    @relationship = Relationship.find_by(follower:current_user, leader: @user)
  end

  def create
    @user = User.new(user_params)

    if @user.save
      MyMailer.register_success_mail(@user).deliver
      follow_each_other if @user.invitor_token
      redirect_to sign_in_path
    else
      render :new
    end
  end

  private

  def follow_each_other
    invitor_id = User.find_by(token: @user.invitor_token).id
    Relationship.create(leader_id: invitor_id, follower_id: @user.id)
    Relationship.create(leader_id: @user.id, follower_id: invitor_id)
  end

  def user_params
    params.require(:user).permit(:email, :password, :full_name, :invitor_token)
  end
end
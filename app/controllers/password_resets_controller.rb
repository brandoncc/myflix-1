class PasswordResetsController < ApplicationController
  def show
    @user = User.find_by(reset_token: params[:id])
    if @user.present?
      @user.update_column("reset_token", nil)
    else
      redirect_to expired_token_path
    end
  end

  def create
    user = User.find_by(token: params[:token])
    user.password = params[:password]

    if user.save
      flash[:notice] = "Your password is reseted successfully!"
      redirect_to sign_in_path
    else
      flash.now[:error] = "Invalid password!"
      redirect_to expired_token_path
    end
  end
end
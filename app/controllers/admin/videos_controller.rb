class Admin::VideosController < ApplicationController
  before_action :require_user

  def new
    if current_user.admin?
      @video = Video.new
    else
      flash[:error] = "You are not allowed to access this page."
      redirect_to home_path
    end
  end
end
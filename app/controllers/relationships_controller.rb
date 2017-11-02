class RelationshipsController < ApplicationController
  before_action :require_user

  def index
    @leaders = current_user.leaders
  end

  def destroy
    Relationship.destroy(params[:id]) if Relationship.find(params[:id]).follower == current_user
    redirect_to people_path
  end
end
class RelationshipsController < ApplicationController
  before_action :require_user

  def index
    @leaders = current_user.leaders
  end

  def create
    if current_user.can_follow?(User.find(params[:leader_id]))
      Relationship.create(leader_id: params[:leader_id], follower: current_user)
    end

    redirect_to people_path
  end

  def destroy
    relationship = Relationship.find(params[:id])
    relationship.destroy if relationship.follower == current_user
    redirect_to people_path
  end
end
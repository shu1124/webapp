class Api::RelationshipsController < ApplicationController
  before_action :authenticate

  def index
    render json: Relationship.where(following_id: params[:user_id], follower_id: current_user.id)
  end

  def create
    user = User.find(params[:following_id])
    current_user.follow(user)
  end

  def destroy
    relationship = Relationship.find(params[:id])
    num = relationship.following_id
    user = User.find(num)
    current_user.unfollow(user)
  end
end

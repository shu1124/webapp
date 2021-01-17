class Api::LikesController < ApplicationController
  def index
    render json: Like.where(user_id: current_user.id, micropost_id: params[:micropost_id])
  end

  def create
    current_user.likes.create!(likes_params)
    head :created
  end

  def destroy
    current_user.likes.find(params[:id]).destroy!
    head :ok
  end

  def count
    render json: Like.where(micropost_id: params[:micropost_id])
  end

  private

  def likes_params
    params.require(:like).permit(:micropost_id).merge(user_id: current_user.id)
  end
end

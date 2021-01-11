class Api::CommentsController < ApplicationController
  before_action :authenticate
  def index
    comments = Comment.where(micropost_id: params[:micropost_id]).order('id DESC')
    render json: comments, each_serializer: CommentSerializer
  end

  def create
    comment = Comment.new(comment_params)
    comment.user_id = current_user.id
    if comment.save
      render json: comment, serializer: CommentSerializer
    else
      render json: comment.errors, status: 422
    end
  end

  private

  def comment_params
    params.permit(:content).merge(user_id: current_user.id, micropost_id: params[:micropost_id])
  end
end

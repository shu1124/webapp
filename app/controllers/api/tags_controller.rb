class Api::TagsController < ApplicationController
  def index
    tags = Tag.all
    render json: tags, each_serializer: TagSerializer
  end
end

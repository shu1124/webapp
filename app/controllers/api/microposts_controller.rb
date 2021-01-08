class Api::MicropostsController < ApplicationController
  before_action :authenticate, only: %i[create update destroy]
  PER_PAGE = 10
  def index
    search_microposts_form = SearchMicropostsForm.new(search_params)
    microposts = search_microposts_form.search.order(created_at: :desc).page(params[:page]).per(PER_PAGE)
    render json: microposts, each_serializer: MicropostSerializer, meta: { total_pages: microposts.total_pages,
                                                                           total_count: microposts.total_count,
                                                                           current_page: microposts.current_page }
  end

  def create
    micropost = current_user.microposts.create!(micropost_params)
    render json: micropost, serializer: MicropostSerializer
  end

  def show
    micropost = Micropost.find(params[:id])
    render json: micropost, serializer: MicropostSerializer
  end

  def update
    micropost = current_user.microposts.find(params[:id])
    current_user.assign_attributes(micropost_params)
    current_user.save_with_genres!(genre_names: genre_names)
    render json: micropost, serializer: MicropostSerializer
  end

  def destroy
    micropost = current_user.microposts.find(params[:id])
    micropost.destroy!
    render json: micropost, serializer: MicropostSerializer
  end

  private

  def micropost_params
    params.permit(:content, :title, :time, :image)
  end

  def search_params
    params[:q]&.permit(:name, genre_ids: [])
  end

  def genre_names
    params.dig(:genre, :genre_names)
  end
end
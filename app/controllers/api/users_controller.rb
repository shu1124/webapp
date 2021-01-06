class Api::UsersController < ApplicationController
  PER_PAGE = 12
  def index
    search_users_form = SearchUsersForm.new(search_params)
    users = search_users_form.search.order(created_at: :desc).page(params[:page]).per(PER_PAGE)
    render json: users, each_serializer: UserSerializer, meta: { total_pages: users.total_pages,
                                                                           total_count: users.total_count,
                                                                           current_page: users.current_page }
  end

  def create
    user = User.new(user_params)
    user.save!
    render json: user, serializer: UserSerializer
  end

  def show
    user = User.find(params[:id])
    render json: user, serializer: UserSerializer
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def search_params
    params[:q]&.permit(:name, tag_ids: [])
  end
end
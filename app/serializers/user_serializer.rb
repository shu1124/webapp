class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :introduction, :avatar_url

  def avatar_url
    if object.avatar.attached?
      Rails.application.routes.url_helpers.rails_blob_path(object.avatar, only_path: true)
    else
      'https://placehold.jp/300x300.png'
    end
  end
end

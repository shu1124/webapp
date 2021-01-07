class MicropostSerializer < ActiveModel::Serializer
  attributes :id, :content, :title, :time, :created_at, :updated_at, image_url
  belongs_to :user

  def image_url
    if object.image.attached?
      Rails.application.routes.url_helpers.rails_blob_path(object.image, only_path: true)
    else
      'https://placehold.jp/300x300.png'
    end
  end
end

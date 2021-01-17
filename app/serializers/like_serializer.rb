class LikeSerializer < ActiveModel::Serializer
  attributes :id, :micropost_id, :user_id
end

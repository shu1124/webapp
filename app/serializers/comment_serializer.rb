class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content, :created_at
  belongs_to :user
  belongs_to :micropost
end

class Like < ApplicationRecord
  belongs_to :user
  belongs_to :micropost
  validates_uniqueness_of :micropost_id, scope: :user_id
  scope :filter_by_post, ->(micropost_id) { where(micropost_id: micropost_id) if micropost_id }
end

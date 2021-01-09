class UserTag < ApplicationRecord
  belongs_to :user
  belongs_to :tag

  validates :user_id, uniqueness: { scope: :tag_id }
end

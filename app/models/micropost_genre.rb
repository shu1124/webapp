class MicropostGenre < ApplicationRecord
  belongs_to :micropost
  belongs_to :genre

  validates :micropost_id, uniqueness: { scope: :genre_id }
end

class MicropostGenre < ApplicationRecord
  belongs_to :micropsot
  belongs_to :genre

  validates :micropost_id, uniqueness: { scope: :genre_id }
end

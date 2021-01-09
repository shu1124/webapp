class Micropost < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :comments
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  validates :content, presence: true, length: { maximum: 1000 }
  validates :title, presence: true, length: { maximum: 30 }
  validates :time, presence: true

  has_many :micropost_genres, dependent: :destroy
  has_many :genres, through: :micropost_genres

  scope :by_name, ->(name) { where('name LIKE ?', "%#{name}%") }
  scope :by_genre, ->(_genre_ids) { joins(:micropost_genres).where(micropost_genres: { genre_id: genres_ids }) }

  def save_with_genres!(genre_names:)
    return save! if genre_names.nil?

    ActiveRecord::Base.transaction do
      self.genres = genre_names.map { |name| Genre.find_or_initialize_by(name: name) }
      save!
    end
    true
  rescue StandardError => e
    false
  end
end

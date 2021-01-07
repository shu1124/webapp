class Micropost < ApplicationRecord
  belongs_to :user
  validates :content, presence: true, length: { maximum: 1000 }
  validates :title, presence: true, length: { maximum: 30 }
  validates :time, presence: true

  has_one_attached :image

end
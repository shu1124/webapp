class Micropost < ApplicationRecord
  belongs_to :user
  has_one_base64_attached :image
  validates :content, presence: true, length: { maximum: 1000 }
  validates :title, presence: true, length: { maximum: 30 }
  validates :time, presence: true
end
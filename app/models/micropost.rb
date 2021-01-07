class Micropost < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :comments
  
  validates :content, presence: true, length: { maximum: 1000 }
  validates :title, presence: true, length: { maximum: 30 }
  validates :time, presence: true

end
class User < ApplicationRecord
  has_secure_password
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true

  has_many :microposts, dependent: :destroy
  has_one_base64_attached :avatar

  has_many :user_tags, dependent: :destroy
  has_many :tags, through: :user_tags

  scope :by_name, ->(name) { where('name LIKE ?', "%#{name}%") }
  scope :by_tag, ->(tag_ids) { joins(:user_tags).where(user_tags: { tag_id: tag_ids }) }
end
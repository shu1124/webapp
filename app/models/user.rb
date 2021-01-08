class User < ApplicationRecord
  has_secure_password
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
  
  has_many :microposts, dependent: :destroy
  has_one_base64_attached :avatar
  has_many :user_tags, dependent: :destroy
  has_many :tags, through: :user_tags
  has_many :comments
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :micropost
  has_many :following_relationships, foreign_key: "follower_id", class_name: "Relationship",  dependent: :destroy
  has_many :following, through: :following_relationships
  has_many :follower_relationships, foreign_key: "following_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :follower_relationships

  scope :by_name, ->(name) { where('name LIKE ?', "%#{name}%") }
  scope :by_tag, ->(tag_ids) { joins(:user_tags).where(user_tags: { tag_id: tag_ids }) }

  def save_with_tags!(tag_names:)
    return save! if tag_names.nil? 

    ActiveRecord::Base.transaction do
      self.tags = tag_names.map { |name| Tag.find_or_initialize_by(name: name) }
      save!
    end
    true
  rescue StandardError => e
    false
  end

  def following?(user)
    following_relationships.find_by(following_id: user.id)
  end

  def follow(user)
    following_relationships.create!(following_id: user.id)
  end

  def unfollow(user)
    following_relationships.find_by(following_id: user.id).destroy
  end
end
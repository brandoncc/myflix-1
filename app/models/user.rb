class User < ActiveRecord::Base
  has_many :reviews, -> { order("created_at DESC")}
  has_many :queue_items, -> { order("position") }

  has_many :following_relationships, class_name: "Relationship", foreign_key: "follower_id"
  has_many :leaders, through: :following_relationships
  has_many :followed_relationships, class_name: "Relationship", foreign_key: "leader_id"
  has_many :followers, through: :followed_relationships

  validates_presence_of :email, :full_name, :password_digest
  validates_uniqueness_of :email

  has_secure_password

  def queued_item?(video)
    !!QueueItem.find_by(user: self, video: video)
  end
end
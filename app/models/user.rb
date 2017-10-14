class User < ActiveRecord::Base
  has_many :reviews
  has_many :queue_items, -> { order("position") }

  validates_presence_of :email, :full_name, :password_digest
  validates_uniqueness_of :email

  has_secure_password

  def queued_item?(video)
    !!QueueItem.find_by(user: self, video: video)
  end
end
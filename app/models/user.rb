class User < ActiveRecord::Base
  has_many :reviews
  has_many :queue_items

  validates_presence_of :email, :full_name, :password_digest
  validates_uniqueness_of :email

  has_secure_password
end
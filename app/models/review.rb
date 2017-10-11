class Review < ActiveRecord::Base
  belongs_to :video
  belongs_to :user

  validates_presence_of :rating
  validates_presence_of :content, unless: :skip_content_validation

  attr_accessor :skip_content_validation
end
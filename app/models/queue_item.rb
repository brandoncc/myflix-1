class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

  delegate :category, to: :video
  delegate :title, to: :video, prefix: :video

  validates :position, numericality: { only_integer: true }

  def rating
    user.reviews.find_by(video: video).try(:rating)
  end

  def category_name
    video.category.name
  end
end
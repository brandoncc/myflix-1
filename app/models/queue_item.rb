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

  def rating=(to_rating)
    if rating.blank?
      review = user.reviews.new(video: video, user: user, rating: to_rating)
      review.skip_content_validation = true
      review.save
    else
      review = Review.find_by(video: video, user: user)
      review.skip_content_validation = true
      review.skip_rating_validation = true
      review.update(rating: to_rating)
    end
  end
end
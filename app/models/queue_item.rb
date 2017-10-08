class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

  delegate :category, to: :video
  delegate :title, to: :video, prefix: :video

  def rating
    review = user.reviews.find_by(video: video)

    if review
      review.rating
    else
      5
    end
  end

  def category_name
    video.category.name
  end
end
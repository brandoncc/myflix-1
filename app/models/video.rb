class Video < ActiveRecord::Base
  belongs_to :category
  has_many :reviews, -> { order('created_at DESC') }
  has_many :queue_items

  validates :title, :description, presence: true

  mount_uploader :small_cover, SmallCoverUploader
  mount_uploader :large_cover, LargeCoverUploader

  def self.search_by_title(title)
    return [] if title.blank?
    where('title LIKE ?', "%#{title}%").order('created_at DESC')
  end
end
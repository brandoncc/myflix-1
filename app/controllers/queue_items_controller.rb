class QueueItemsController < ApplicationController
  before_action :require_user

  def index
    @queue_items = current_user.queue_items
  end

  def create
    video = Video.find(params[:video_id])
    create_queue_item(video)

    redirect_to my_queue_path
  end

  def destroy
    queue_item = QueueItem.find(params[:id])
    if queue_item.user == current_user
      queue_item.destroy
    end
    redirect_to my_queue_path
  end

  private

  def create_queue_item(video)
    if queue_item_not_exists?(video)
      position = current_user.queue_items.count + 1
      QueueItem.create(video: video, user: current_user, position: position)
    end
  end

  def queue_item_not_exists?(video)
    !current_user.queue_items.find_by video: video
  end
end
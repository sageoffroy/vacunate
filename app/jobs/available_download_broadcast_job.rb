# app/jobs/available_download_broadcast_job.rb
class AvailableDownloadBroadcastJob < ApplicationJob
  queue_as :default

  def perform(uuid)
    csv = DownloadPeople.call
    ActionCable.server.broadcast(
      "downloads_channel_#{uuid}", csv: csv
    )
  end
end

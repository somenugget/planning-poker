class RoomChannel < ApplicationCable::Channel
  def subscribed
    return reject unless params[:room_id]

    stream_from channel_name
    result = RoomUser::Online.(params: { room_id: params[:room_id], user_id: current_user.id })

    Cables::UserOnlineJob.perform_later(result[:model]) if result.success?
  end

  def receive(data)
    ActionCable.server.broadcast channel_name, data
  end

  def unfollow
    stop_all_streams
  end

  private

  def channel_name
    "room:#{params[:room_id]}"
  end
end

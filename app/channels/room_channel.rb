class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room:#{params[:room_id]}"

    result = RoomUser::Online.(params: { room_id: params[:room_id], user_id: current_user.id })

    Cables::UserOnlineJob.perform_later(result[:model]) if result.success?
  end

  def receive(data)
    ActionCable.server.broadcast("room:#{params[:room_id]}", data)
  end

  def unfollow
    stop_all_streams
  end
end

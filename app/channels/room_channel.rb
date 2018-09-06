class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room:#{params[:room_id]}"
  end

  def receive(data)
    ActionCable.server.broadcast("room:#{params[:room_id]}", data)
  end

  def unfollow
    stop_all_streams
  end
end

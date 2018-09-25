module Cables
  class RoomClosed < ApplicationJob
    def perform(room_id, average)
      RoomChannel.broadcast_to room_id, message: :room_closed, data: { average: average }
    end
  end
end

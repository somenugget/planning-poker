module Cables
  class UserVoted < ApplicationJob
    def perform(room_user)
      RoomChannel.broadcast_to room_user.room_id,
                               message: :user_voted,
                               data: RoomUser::Representer::Json.new(room_user).as_json
    end
  end
end

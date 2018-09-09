class RoomUser < ApplicationRecord
  belongs_to :room
  belongs_to :user

  def find_by_relations(room_id:, user_id:)
    find_by!(room_id: room_id, user_id: user_id)
  end
end

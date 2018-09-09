module RoomUser::Contract
  class Join < BaseCreate
    property :user
    property :room_id

    validation do
      required(:room_id).int?

      required(:user).schema do
        required(:name).str?
      end
    end
  end
end

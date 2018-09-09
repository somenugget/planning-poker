module RoomUser::Contract
  class CreateWithRelations < BaseCreate
    validation do
      required(:user).schema do
        required(:name).str?
      end

      required(:room).schema do
        required(:name).str?
      end
    end
  end
end

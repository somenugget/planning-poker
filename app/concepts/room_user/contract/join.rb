require 'reform'
require 'reform/form/dry'

module RoomUser::Contract
  class Join < Reform::Form
    include Dry

    property :admin
    property :user
    property :room_id

    validation do
      required(:admin).bool?
      required(:room_id).int?

      required(:user).schema do
        required(:name).str?
      end
    end
  end
end

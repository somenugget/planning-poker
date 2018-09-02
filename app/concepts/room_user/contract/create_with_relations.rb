require 'reform'
require 'reform/form/dry'

module RoomUser::Contract
  class CreateWithRelations < Reform::Form
    include Dry

    property :admin
    property :user
    property :room

    validation do
      required(:admin).bool?

      required(:user).schema do
        required(:name).filled
      end

      required(:room).schema do
        required(:name).filled
      end
    end

  end
end

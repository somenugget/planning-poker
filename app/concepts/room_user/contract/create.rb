require 'reform'
require 'reform/form/dry'

module RoomUser::Contract
  class Create < Reform::Form
    include Dry

    property :admin
    property :user
    property :room

    validation do
      required(:admin).bool?
      required(:user)
      required(:room)
    end
  end
end

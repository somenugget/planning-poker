require 'reform'
require 'reform/form/dry'

module RoomUser::Contract
  class BaseCreate < Reform::Form
    include Dry

    property :admin
    property :online
    property :user
    property :room

    validation do
      required(:admin).bool?
      required(:online).bool?
      required(:user)
      required(:room)
    end
  end
end

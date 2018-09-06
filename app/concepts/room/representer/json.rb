require 'representable/json'

# require_relative '../../room_user/representer/json'

module Room::Representer
  class Json < Representable::Decorator
    include Representable::JSON

    property :id
    property :name

    collection :room_users, decorator: RoomUser::Representer::Json
  end
end

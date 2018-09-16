require 'roar/decorator'
require 'roar/json'

module Vote::Representer
  class Json < Roar::Decorator
    include Roar::JSON

    property :id
    property :estimation
    property :room_user, decorator: RoomUser::Representer::Json
  end
end

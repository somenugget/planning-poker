require 'roar/decorator'
require 'roar/json'

module RoomUser::Representer
  class Json <  Roar::Decorator
    include Roar::JSON

    property :id
    property :admin?

    property :user, decorator: User::Representer::Json
  end
end

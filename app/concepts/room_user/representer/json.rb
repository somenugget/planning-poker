require 'representable/json'

module RoomUser::Representer
  class Json < Representable::Decorator
    include Representable::JSON

    property :id
    property :admin?

    property :user, decorator: User::Representer::Json
  end
end

require 'representable/json'


module User::Representer
  class Json < Representable::Decorator
    include Representable::JSON

    property :id
    property :name
  end
end

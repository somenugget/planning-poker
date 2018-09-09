require 'roar/decorator'
require 'roar/json'

module User::Representer
  class Json < Roar::Decorator
    include Roar::JSON

    property :id
    property :name
  end
end

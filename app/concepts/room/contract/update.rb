require 'reform'
require 'reform/form/dry'

module Room::Contract
  class Update < Reform::Form
    include Dry

    property :closed

    validation do
      required(:closed).bool?
    end
  end
end

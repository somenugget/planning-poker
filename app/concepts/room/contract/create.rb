require 'reform'
require 'reform/form/dry'

module Room::Contract
  class Create < Reform::Form
    include Dry

    property :name

    validation do
      required(:name).filled
    end
  end
end

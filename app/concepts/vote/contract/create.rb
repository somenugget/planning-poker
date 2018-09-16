require 'reform'
require 'reform/form/dry'

module Vote::Contract
  class Create < Reform::Form
    include Dry

    property :room_user_id
    property :estimation

    validation do
      required(:room_user_id).int?
      required(:estimation).int?
    end
  end
end

require 'reform'
require 'reform/form/dry'

module Question::Contract
  class Create < Reform::Form
    include Dry

    property :content
    property :room_id

    validation do
      required(:content).min_size? 3
      required(:room_id).int?
    end
  end
end

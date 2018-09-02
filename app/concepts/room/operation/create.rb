class Room::Create < Trailblazer::Operation
  class Present < Trailblazer::Operation
    step Model(Room, :new)
    step Contract::Build(constant: Room::Contract::Create)
  end

  step Nested(Present)
  step Contract::Validate(key: :room)
  step :generate_hash!
  step Contract::Persist()

  def generate_hash!(_options, model:, **)
    loop do
      model.uri_hash = SecureRandom.hex(Room::URI_HASH_LENGTH / 2)
      break unless Room.where(uri_hash: model.uri_hash).exists?
    end

    true
  end
end

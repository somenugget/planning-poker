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
      model.slug = SecureRandom.hex
      break unless Room.where(slug: model.slug).exists?
    end

    true
  end
end

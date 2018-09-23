class Room::Update < Trailblazer::Operation
  step Model(Room, :find_by)
  step Contract::Build(constant: Room::Contract::Update)
  step Contract::Validate()
  step Contract::Persist()
end

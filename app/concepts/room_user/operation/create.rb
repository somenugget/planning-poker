class RoomUser::Create < Trailblazer::Operation
  class Present < Trailblazer::Operation
    step Model(RoomUser, :new)
    step Contract::Build(constant: RoomUser::Contract::Create)
  end

  step Nested(Present)
  step Contract::Validate(key: :room_user)
  step Contract::Persist()
end

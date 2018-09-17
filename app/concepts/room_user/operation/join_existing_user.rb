class RoomUser::JoinExistingUser < Trailblazer::Operation
  class Present < Trailblazer::Operation
    step :find_room_by_slug!
    step Model(RoomUser, :new)
    step Contract::Build(constant: RoomUser::Contract::Create)

    def find_room_by_slug!(options, params:, **)
      options[:room] = Room.find_by! slug: params[:slug]
    end
  end

  step Nested(Present)
  step Contract::Validate(key: :room_user)
  step :persist

  def persist(options, params:, **)
    result = RoomUser::Create.(params: params.deep_merge(room_user: { room: options[:room] }))
    options[:model] = result[:model]
    result.success?
  end
end

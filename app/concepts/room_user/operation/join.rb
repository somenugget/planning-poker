class RoomUser::Join < Trailblazer::Operation
  class Present < Trailblazer::Operation
    step :find_room_by_slug!
    step :ensure_room_is_opened
    step Model(RoomUser, :new)
    step Contract::Build(constant: RoomUser::Contract::Join)

    def find_room_by_slug!(options, params:, **)
      options[:room] = Room.find_by! slug: params[:slug]
    end

    def ensure_room_is_opened(options, **)
      !options[:room].closed?
    end
  end

  step Nested(Present)
  step Contract::Validate(key: :room_user)
  step :save_user
  step :persist

  def save_user(_options, params:, **)
    result = User::Create.(params: params[:room_user])
    params[:room_user][:user] = result[:model]

    result.success?
  end

  def persist(options, params:, **)
    result = RoomUser::Create.(params: params.deep_merge(room_user: { room: options[:room] }))
    options[:model] = result[:model]
    result.success?
  end
end

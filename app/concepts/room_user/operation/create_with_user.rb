class RoomUser::CreateWithUser < Trailblazer::Operation
  class Present < Trailblazer::Operation
    step Model(RoomUser, :new)
    step Contract::Build(constant: RoomUser::Contract::CreateWithUser)
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
    result = RoomUser::Create.(params: params)
    options[:model] = result[:model]

    result.success?
  end
end

class RoomUser::CreateWithRelations < Trailblazer::Operation
  class PresentWithRelations < Trailblazer::Operation
    step Model(RoomUser, :new)
    step Contract::Build(constant: RoomUser::Contract::CreateWithRelations)
  end

  step Nested(PresentWithRelations)
  step Contract::Validate(key: :room_user)
  step :save_user
  step :save_room
  step :persist

  def save_user(options, params:, **)
    result = User::Create.(params: params[:room_user])
    params[:room_user][:user] = result[:model]

    result.success?
  end

  def save_room(_options, params:, **)
    result = Room::Create.(params: params[:room_user])
    params[:room_user][:room] = result[:model]

    result.success?
  end

  def persist(options, params:, **)
    result = RoomUser::Create.(params: params)
    options[:model] = result[:model]

    result.success?
  end
end

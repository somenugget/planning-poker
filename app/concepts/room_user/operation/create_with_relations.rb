class RoomUser::CreateWithRelations < Trailblazer::Operation
  class PresentWithRelations < Trailblazer::Operation
    step Model(RoomUser, :new)
    step Contract::Build(constant: RoomUser::Contract::CreateWithRelations)
  end

  step Nested(PresentWithRelations)
  step Contract::Validate(key: :room_user)
  step :save_user
  step :save_room
  step :save_question
  step :persist

  def save_user(_options, params:, **)
    save_entity :user, User::Create, params
  end

  def save_room(_options, params:, **)
    save_entity :room, Room::Create, params
  end

  def save_question(_options, params:, **)
    params[:room_user][:question][:room] = params[:room_user][:room]
    save_entity :question, Question::Create, params
  end

  def persist(options, params:, **)
    result = RoomUser::Create.(params: params)
    options[:model] = result[:model]

    result.success?
  end

  private

  def save_entity(entity_name, operation, params)
    result = operation.(params: params[:room_user])
    params[:room_user][entity_name] = result[:model]

    result.success?
  end
end

class RoomUser::Online < Trailblazer::Operation
  step :find
  step :set_online
  step :persist

  def find(options, params:, **)
    options[:model] = RoomUser.find_by(room_id: params[:room_id], user_id: params[:user_id])
  end

  def set_online(options, **)
    options[:model].online = true
  end

  def persist(options, **)
    options[:model].save
  end
end

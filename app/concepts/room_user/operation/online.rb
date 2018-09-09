class RoomUser::Online < Trailblazer::Operation
  step :find
  step :set_online
  step :persist

  def find(options, params:, **)
    options[:model] = RoomUser.find_by_relations!(params)
  end

  def set_online(options, **)
    options[:model].online = true
  end

  def persist(options, **)
    options[:model].save!
  end
end

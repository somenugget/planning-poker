class RoomUser::Offline < Trailblazer::Operation
  step :find
  success :set_offline
  step :persist

  def find(options, params:, **)
    options[:model] = RoomUser.find_by_relations!(params)
  end

  def set_offline(options, **)
    options[:model].online = false
  end

  def persist(options, **)
    options[:model].save!
  end
end

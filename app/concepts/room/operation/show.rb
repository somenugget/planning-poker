class Room::Show < Trailblazer::Operation
  step :find_by_slug

  def find_by_slug(options, params:, **)
    options[:model] = Room.where(slug: params[:slug]).includes(room_users: :user).first!
  end
end

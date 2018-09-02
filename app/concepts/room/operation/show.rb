class Room::Show < Trailblazer::Operation
  step Model(Room, :find_by_slug!, :slug)
end

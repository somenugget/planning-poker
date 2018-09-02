class Room::Show < Trailblazer::Operation
  step Model(Room, :find_by)
end

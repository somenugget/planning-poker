module Room::Cell
  class Join < Trailblazer::Cell
    include ActionView::RecordIdentifier

    def admin_name
      options[:room].room_users.find_by(admin: true).user.name
    end

    def room
      options[:room]
    end

    def room_name
      room.name
    end
  end
end

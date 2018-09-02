module Room::Cell
  class Show < Trailblazer::Cell
    include ActionView::RecordIdentifier

    def current_user
      options[:current_user]
    end

    def room_users
      model.room_users.includes(:user).order(:admin)
    end
  end
end

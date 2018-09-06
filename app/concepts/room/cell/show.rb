module Room::Cell
  class Show < Trailblazer::Cell
    include ActionView::RecordIdentifier
    include ActionView::Helpers::UrlHelper
    include Webpacker::Helper

    def current_user
      options[:current_user]
    end

    def current_user_admin?
      room_users.find_by(user_id: current_user.id).admin?
    end

    def room_users
      model.room_users.includes(:user).order(:admin)
    end

    def link_to_share
      content_tag(:h4) { link_to 'Link to share', join_path(model) } if current_user_admin?
    end

    def json
      Room::Representer::Json.new(model).to_json.gsub(/"/, '&quot;'.freeze)
    end
  end
end

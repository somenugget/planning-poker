module Room::Cell
  class Show < Trailblazer::Cell
    include ActionView::RecordIdentifier
    include ActionView::Helpers::UrlHelper
    include Webpacker::Helper

    def current_user
      options[:current_user]
    end

    def current_user_admin?
      model.admin.user_id == current_user.id
    end

    def link_to_share
      join_url(model) if current_user_admin?
    end

    def average
      Result::Calculate.(params: { room_users: model.room_users })[:average] if model.closed?
    end

    def json
      Room::Representer::Json.new(model)
                             .to_json(user_options: { current_user: current_user,
                                                      link_to_share: link_to_share,
                                                      average: average })
                             .gsub(/"/, '&quot;'.freeze)
    end
  end
end

require 'roar/decorator'
require 'roar/json'
require 'roar/hypermedia'

module Room::Representer
  class Json < Roar::Decorator
    include Roar::JSON
    include Roar::Hypermedia
    include Rails.application.routes.url_helpers

    property :id
    property :name

    property :current_user,
             decorator: User::Representer::Json,
             getter: ->(options:, **) { options[:user_options][:current_user] }

    property :link_to_share,
             getter: ->(options:, **) { options[:user_options][:link_to_share] }

    property :question do
      property :content
    end

    collection :room_users,
               decorator: RoomUser::Representer::Json,
               getter: (lambda do |represented:, **|
                 represented.room_users.order admin: :desc, online: :desc, created_at: :asc
               end)
  end
end

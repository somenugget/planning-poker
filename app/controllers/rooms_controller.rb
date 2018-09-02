class RoomsController < ApplicationController
  def show
    run Room::Show
    render cell(Room::Cell::Show, result[:model], current_user: current_user)
  end
end

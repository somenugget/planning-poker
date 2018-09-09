class RoomsController < ApplicationController
  def show
    return redirect_to join_path(params[:slug]) unless current_user

    run Room::Show
    render cell(Room::Cell::Show, result[:model], current_user: current_user)
  end
end

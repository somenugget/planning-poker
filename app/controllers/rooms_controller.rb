class RoomsController < ApplicationController
  def new
    run Room::Create::Present
    render cell(Room::Cell::New, @form)
  end

  def create
    run Room::Create do |result|
      return redirect_to room_path(result[:model])
    end

    render cell(Room::Cell::New, @form)
  end

  def show
    run Room::Show
    render cell(Room::Cell::Show, result[:model])
  end
end

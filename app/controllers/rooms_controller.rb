class RoomsController < ApplicationController
  def show
    return redirect_to join_room_path(params[:slug]) unless current_user

    run Room::Show
    render cell(Room::Cell::Show, result[:model], current_user: current_user)
  end

  def join
    room = Room.includes(room_users: :user).find_by(slug: params[:slug])
    return redirect_to root_path unless room

    run(RoomUser::CreateWithUser::Present)
    render cell(Room::Cell::Join, result[:model], room: room)
  end

  def join_room
    room = Room.includes(room_users: :user).find_by(slug: params[:slug])
    return redirect_to root_path unless room

    hash_params = params.permit(room_user: { user: :name, room: :name }).to_h
    hash_params[:room_user][:room] = room

    run(RoomUser::CreateWithUser, params: hash_params) do |result|
      session[:current_user_id] = result[:model].user.id
      return redirect_to room_path result[:model].room
    end

    render cell(Room::Cell::Join, result[:model], room: room)
  end
end

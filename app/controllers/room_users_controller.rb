class RoomUsersController < ApplicationController
  def new
    return new_join if params[:slug]
    new_room
  end

  def create
    return join_room if params[:slug]
    create_room
  end

  private

  def new_room
    run RoomUser::Create::Present
    render cell(RoomUser::Cell::New, @form)
  end

  def create_room
    run(RoomUser::CreateWithRelations, params: hash_params) do |result|
      session[:current_user_id] = result[:model].user.id
      return redirect_to room_path result[:model].room
    end

    render cell(RoomUser::Cell::New, @form)
  end

  def new_join
    run(RoomUser::Join::Present)
    render cell(RoomUser::Cell::Join, result[:model], room: result[:room])
  end

  def join_room
    run(RoomUser::Join, params: hash_params) do |result|
      session[:current_user_id] = result[:model].user.id
      return redirect_to room_path result[:model].room
    end

    render cell(RoomUser::Cell::Join, result[:model], room: result[:room])
  end
end

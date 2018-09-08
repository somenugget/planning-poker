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
    run RoomUser::CreateWithRelations,
        params: hash_params.deep_merge(room_user: { admin: true, online: true }) do |result|
      return room_user_created result[:model]
    end

    render cell(RoomUser::Cell::New, @form)
  end

  def new_join
    run(RoomUser::Join::Present)
    render cell(RoomUser::Cell::Join, result[:model], room: result[:room])
  end

  def join_room
    run(RoomUser::Join, params: hash_params.deep_merge(room_user: { online: true })) do |result|
      Cables::UserJoinedRoomJob.perform_later result[:model]

      return room_user_created result[:model]
    end

    render cell(RoomUser::Cell::Join, result[:model], room: result[:room])
  end

  def room_user_created(room_user)
    self.current_user = room_user.user
    redirect_to room_path room_user.room
  end
end

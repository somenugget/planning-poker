class RoomUsersController < ApplicationController
  def new
    return join_user_to_room if current_user && params[:slug]
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
    result = RoomUser::Join::Present.(params: params.permit!)

    cell_class = result[:room].closed? ? RoomUser::Cell::Closed : RoomUser::Cell::Join
    render cell(cell_class, result[:model], room: result[:room])
  end

  def join_user_to_room
    join RoomUser::JoinExistingUser, slug: params[:slug], room_user: { online: true,
                                                                       user: current_user }
  end

  def join_room
    join RoomUser::Join, hash_params.deep_merge(room_user: { online: true })
  end

  def join(operation_class, operation_params)
    run(operation_class, params: operation_params) do |result|
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

class RoomUsersController < ApplicationController
  def new
    run RoomUser::Create::Present
    render cell(RoomUser::Cell::New, @form)
  end

  def create
    hash_params = params.permit(room_user: { user: :name, room: :name }).to_h
    hash_params[:room_user][:admin] = true

    run(RoomUser::CreateWithRelations, params: hash_params) do |result|
      session[:current_user_id] = result[:model].user.id
      return redirect_to room_path result[:model].room
    end

    render cell(RoomUser::Cell::New, @form)
  end
end

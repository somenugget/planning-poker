require 'rails_helper'

RSpec.describe RoomUsersController, type: :controller do
  context 'no room created' do
    describe 'new room creation' do
      let(:room_user_params) { { room_user: { user: { name: 'Dima' }, room: { name: 'Planning' } } } }

      it 'creates room' do
        expect(controller).to receive(:current_user=).with(instance_of(User))

        post :create, params: room_user_params

        expect(response).to redirect_to(Room.last)
      end
    end
  end

  context 'room already created' do
    describe 'room joining' do
      let(:room) { Room.create(name: 'Room', slug: 'slug') }
      let(:room_user_params) { { room_user: { user: { name: 'Dima' } }, slug: room.slug } }

      it 'user joins room' do
        expect(Cables::UserJoinedRoomJob).to receive(:perform_later).with(instance_of(RoomUser))

        post :create, params: room_user_params

        expect(response).to redirect_to(room)
      end
    end
  end
end

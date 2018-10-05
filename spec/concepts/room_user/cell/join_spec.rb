require 'rails_helper'

RSpec.describe RoomUser::Cell::Join, type: :cell do
  include Cell::Testing
  controller RoomUsersController

  let(:room_user) do
    user = User.create name: 'Dima'
    room = Room.create name: 'Plan', slug: '1'
    RoomUser::Create.(params: { room_user: { user: user, room: room, admin: true } })[:model]
  end

  describe 'cell' do
    subject(:result) { cell(described_class, room_user, room: room_user.room) }

    it 'shows admin name' do
      expect(result.admin_name).to eq('Dima')
    end

    it 'shows room' do
      expect(result.room).to eq(room_user.room)
    end

    it 'shows room name' do
      expect(result.room_name).to eq('Plan')
    end
  end
end

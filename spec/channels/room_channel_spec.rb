require 'rails_helper'

RSpec.describe RoomChannel, type: :channel do
  let(:user) { User.create(name: 'Dima') }

  before do
    stub_connection current_user: user
  end

  context 'without room id' do
    it 'rejects' do
      subscribe
      expect(subscription).to be_rejected
    end
  end

  context 'with room id' do
    let(:room) { Room.create name: 'Planning' }

    before do
      expect(RoomUser::Online).to(
        receive(:call)
          .with(params: { room_id: room.id, user_id: user.id })
          .and_return(double(:success? => true, :[] => :fake))
      )
      expect(Cables::UserOnlineJob).to receive(:perform_later).with(:fake)

      subscribe room_id: room.id
    end

    it 'subscribes' do
      expect(subscription).to be_confirmed
      expect(streams).to include("room:#{room.id}")
    end

    it 'unsubscribes' do
      expect(RoomUser::Offline).to(
        receive(:call)
          .with(params: { room_id: room.id, user_id: user.id })
          .and_return(double(:success? => true, :[] => :fake))
      )
      expect(Cables::UserOfflineJob).to receive(:perform_later).with(:fake)

      subscription.unsubscribe_from_channel

      expect(streams).to be_empty
    end
  end
end

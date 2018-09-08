require 'rails_helper'

RSpec.describe RoomChannel, type: :channel do
  let(:user) { User.create(name: 'Dima') }

  before do
    stub_connection current_user: user
  end

  it 'rejects when no room id' do
    subscribe
    expect(subscription).to be_rejected
  end

  it 'rejects when no room id' do
    room = Room.create name: 'Planning'

    expect(RoomUser::Online).to(
      receive(:call)
        .with(params: { room_id: room.id, user_id: user.id })
        .and_return(double(:success? => true, :[] => :fake))
    )
    expect(Cables::UserOnlineJob).to receive(:perform_later).with(:fake)

    subscribe room_id: room.id

    expect(subscription).to be_confirmed
    expect(streams).to include("room:#{room.id}")
  end
end

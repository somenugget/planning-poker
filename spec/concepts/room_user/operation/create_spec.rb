RSpec.describe RoomUser::Create do
  it 'creates a room' do
    user = User.create name: 'Dima'
    room = Room.create name: 'Plan'
    result = described_class.(params: { room_user: { user: user, room: room, admin: true } })

    expect(result.success?).to be_truthy
    expect(result[:model].persisted?).to be_truthy
    expect(result[:model].user).to be_eql(user)
    expect(result[:model].room).to be_eql(room)
  end
end

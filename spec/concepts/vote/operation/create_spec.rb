RSpec.describe Vote::Create do
  let(:room_user) do
    user = User.create name: 'Dima'
    room = Room.create name: 'Plan'
    RoomUser::Create.(params: { room_user: { user: user, room: room, admin: true } })[:model]
  end

  it 'creates a vote' do
    vote_params = { room_user_id: room_user.id, estimation: 1 }
    result = described_class.(params: { vote: vote_params })

    expect(result.success?).to be_truthy
    expect(result[:model].id).to be_eql(Vote.find_by(vote_params).id)
  end
end

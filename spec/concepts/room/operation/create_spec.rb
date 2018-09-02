RSpec.describe Room::Create do
  it 'creates a room' do
    room_params = { name: 'room' }
    result = described_class.(params: { room: room_params })

    expect(result.success?).to be_truthy
    expect(result[:model].id).to be_eql(Room.find_by(room_params).id)
    expect(result[:model].slug).not_to be_falsey
  end
end

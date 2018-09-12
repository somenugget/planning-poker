RSpec.describe RoomUser::CreateWithRelations do
  it 'creates a room' do
    user_params = { name: 'Dima' }
    room_params = { name: 'Plan' }
    question_params = { content: 'How are you?' }
    result = described_class.(params: { room_user: { user: user_params,
                                                     room: room_params,
                                                     question: question_params } })

    expect(result.success?).to be_truthy
    expect(result[:model].persisted?).to be_truthy
    expect(User.where(user_params).exists?).to be_truthy
    expect(Room.where(room_params).exists?).to be_truthy
    expect(Question.where(question_params).exists?).to be_truthy
  end
end

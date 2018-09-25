require 'rails_helper'

RSpec.describe Cables::UserVoted, type: :job do
  describe 'job' do
    let(:room_user) do
      user_params = { name: 'Dima' }
      room_params = { name: 'Plan' }
      question_params = { content: 'How are you?' }
      result = RoomUser::CreateWithRelations.(params: { room_user: { user: user_params,
                                                                     room: room_params,
                                                                     question: question_params } })
      result[:model]
    end

    it 'broadcasts message to cable' do
      allow_any_instance_of(RoomUser::Representer::Json)
        .to receive(:as_json).and_return('{"right_json": true}')
      expect(RoomChannel).to receive(:broadcast_to).with(
        room_user.room_id,
        hash_including(message: :user_voted, data: '{"right_json": true}')
      )
      described_class.perform_now room_user
    end
  end
end

require 'rails_helper'

RSpec.describe Cables::UserOnlineJob, type: :job do
  describe 'job' do
    it 'broadcasts message to cable' do
      allow_any_instance_of(RoomUser::Representer::Json)
        .to receive(:as_json)
        .and_return('{"right_json": true}')
      expect(RoomChannel)
        .to receive(:broadcast_to)
        .with(1, hash_including(message: :user_online, data: '{"right_json": true}'))

      described_class.perform_now OpenStruct.new(room_id: 1)
    end
  end
end

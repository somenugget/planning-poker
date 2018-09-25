require 'rails_helper'

RSpec.describe Cables::RoomClosed, type: :job do
  describe 'job' do
    it 'broadcasts message to cable' do
      expect(RoomChannel).to receive(:broadcast_to).with(
        1, hash_including(message: :room_closed, data: { average: 1 })
      )
      described_class.perform_now 1, 1
    end
  end
end

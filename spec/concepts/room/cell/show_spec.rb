require 'rails_helper'


RSpec.describe Room::Cell::Show, type: :cell do
  include Cell::Testing
  controller RoomsController

  describe 'cell' do
    let(:room_user) do
      user = User.create name: 'Dima'
      room = Room.create name: 'Plan', slug: '1'
      RoomUser::Create.(params: { room_user: { user: user, room: room, admin: true } })[:model]
    end

    context 'current_user is admin' do
      subject(:result) { cell(described_class, room_user.room, current_user: room_user.user) }

      it 'shows that current_user is admin' do
        expect(result.current_user_admin?).to be_truthy
      end

      it 'shows link to share room' do
        expect(result.link_to_share).to be_eql('http://test.host/1/join')
      end

      it 'shows json representation' do
        expect_any_instance_of(Room::Representer::Json)
          .to receive(:to_json)
          .with(user_options: { current_user: room_user.user,
                                link_to_share: result.link_to_share })
          .and_return('{"some": "json"}')

        result.json
      end
    end
  end
end

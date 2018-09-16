require 'rails_helper'

RSpec.describe Api::VotesController, type: :controller do
  describe 'first time vote' do
    let(:room_user) do
      user = User.create name: 'Dima'
      room = Room.create name: 'Plan'
      RoomUser::Create.(params: { room_user: { user: user, room: room, admin: true } })[:model]
    end

    it 'creates vote' do
      controller.instance_variable_set '@current_user', room_user.user

      post :create, params: { vote: { room_user_id: room_user.id, estimation: 1 } }

      expect(response).to have_http_status 200
      expect(JSON.parse(response.body)['id']).to eql(Vote.last.id)
    end
  end
end

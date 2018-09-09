require 'rails_helper'

RSpec.describe ApplicationCable::Connection, type: :channel do
  let(:user) { User.create name: 'Dima' }

  it 'connects' do
    allow_any_instance_of(described_class).to(
      receive(:cookies).and_return(double(encrypted: { current_user_id: user.id }))
    )

    connect '/websocket'

    expect(connection.current_user).to eq user
  end

  it 'raises error without user' do
    allow_any_instance_of(described_class).to(
      receive(:cookies).and_return(double(encrypted: { current_user_id: 111 }))
    )

    expect { connect '/websocket' }
      .to raise_error(ActionCable::Connection::Authorization::UnauthorizedError)
  end
end

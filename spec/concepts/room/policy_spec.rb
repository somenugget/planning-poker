require 'rails_helper'

RSpec.describe Room::Policy, type: :policy do
  it 'gives view access only for users in room' do
    policy = described_class.new(1, OpenStruct.new(users: [1, 2, 3]))
    expect(policy.view?).to be_truthy
  end
end

require 'rails_helper'

RSpec.describe Room, type: :model do
  it 'uses slug as params' do
    room = described_class.new
    room.slug = 'slug'
    expect(room.to_param).to be_eql('slug')
  end
end

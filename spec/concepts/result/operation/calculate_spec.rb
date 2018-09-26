RSpec.describe Result::Calculate do
  it 'calculates results with rounding to a greater' do
    room_users = [OpenStruct.new(vote: OpenStruct.new(estimation: 1)),
                  OpenStruct.new(vote: OpenStruct.new(estimation: 3))]
    result = Result::Calculate.(params: { room_users: room_users })

    expect(result.success?).to be_truthy
    expect(result[:average]).to be_eql(3)
  end
end

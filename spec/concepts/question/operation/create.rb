RSpec.describe Question::Create do
  it 'creates a question' do
    room = Room.create name: 'room'
    question_params = { content: 'how do you do?', room: room }
    result = described_class.(params: { question: question_params })

    expect(result.success?).to be_truthy
    expect(result[:model].id).to be_eql(Question.find_by(question_params).id)
  end
end

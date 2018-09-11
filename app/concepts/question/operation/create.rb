class Question::Create < Trailblazer::Operation
  class Present < Trailblazer::Operation
    step Model(Question, :new)
    step Contract::Build(constant: Question::Contract::Create)
  end

  step Nested(Present)
  step Contract::Validate(key: :question)
  step Contract::Persist()
end

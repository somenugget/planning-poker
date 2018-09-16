class Vote::Create < Trailblazer::Operation
  class Present < Trailblazer::Operation
    step Model(Vote, :new)
    step Contract::Build(constant: Vote::Contract::Create)
  end

  step Nested(Present)
  step Contract::Validate(key: :vote)
  step Contract::Persist()
end

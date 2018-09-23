class Result::Calculate < Trailblazer::Operation
  step :calculate

  def calculate(options, params:, **)
    estimations = params[:room_users].select(&:vote)
                                     .map { |room_user| room_user.vote.estimation }
    options[:average] = average_estimation(estimations)
  end

  def average_estimation(estimations)
    average = estimations.sum.to_f / estimations.size
    Vote::ESTIMATIONS_AVAILABLE.min(2) do |estimation, next_estimation|
      (estimation - average).abs <=> (next_estimation - average).abs
    end.max
  end
end

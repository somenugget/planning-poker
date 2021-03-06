module Api
  class VotesController < ApplicationController
    def create
      result = Vote::Create.(params: params.permit!)

      if result.success?
        Cables::UserVoted.perform_later result[:model].room_user
        render json: Vote::Representer::Json.new(result[:model]).to_json, status: 200
      else
        render json: result['contract.default'].errors.full_messages, status: 422
      end
    end
  end
end

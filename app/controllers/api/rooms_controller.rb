module Api
  class RoomsController < ApplicationController
    def update
      result = Room::Update.(params: params.permit!)

      return render_errors result['contract.default'].errors.full_messages if result.failure?

      calculation_result = ::Result::Calculate.(params: { room_users: result[:model].room_users })

      return render_errors ['Could not calculate result'] if calculation_result.failure?

      Cables::RoomClosed.perform_later result[:model].id, calculation_result[:average]

      render json: { average: calculation_result[:average] }
    end
  end
end

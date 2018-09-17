class RoomsController < ApplicationController
  def show
    return redirect_to_join unless current_user

    run(Room::Show, params: params, current_user: current_user) do |result|
      render cell(Room::Cell::Show, result[:model], current_user: current_user)
    end

    return redirect_to_join unless result['result.policy.default'].success?
  end

  private

  def redirect_to_join
    redirect_to join_path params[:slug]
  end
end

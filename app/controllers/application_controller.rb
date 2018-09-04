class ApplicationController < ActionController::Base
  def current_user
    @current_user ||= User.find_by(id: session[:current_user_id])
  end

  private

  def hash_params
    params.permit!.to_hash.deep_symbolize_keys
  end
end

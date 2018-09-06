class ApplicationController < ActionController::Base
  def current_user
    @current_user ||= User.find_by(id: cookies.encrypted[:current_user_id])
  end

  private

  def current_user=(user)
    @current_user = user
    cookies.encrypted[:current_user_id] = user.id
  end

  def hash_params
    params.permit!.to_hash.deep_symbolize_keys
  end
end

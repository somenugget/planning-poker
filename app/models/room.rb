class Room < ApplicationRecord
  has_many :room_users
  has_many :users, through: :room_users

  def to_param
    slug
  end

  def admin
    room_users.includes(:user).find_by(admin: true)
  end
end

class AddDefaultValueToAdminInRoomUsers < ActiveRecord::Migration[5.2]
  def change
    change_column_default :room_users, :admin, from: nil, to: false
  end
end

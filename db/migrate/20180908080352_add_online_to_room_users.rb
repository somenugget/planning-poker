class AddOnlineToRoomUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :room_users, :online, :boolean, default: false
  end
end

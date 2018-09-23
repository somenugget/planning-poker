class AddClosedToRooms < ActiveRecord::Migration[5.2]
  def change
    add_column :rooms, :closed, :boolean, default: false, null: false
  end
end

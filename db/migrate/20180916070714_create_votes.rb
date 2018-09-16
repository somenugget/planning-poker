class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.references :room_user, foreign_key: true
      t.integer :estimation

      t.timestamps
    end
  end
end

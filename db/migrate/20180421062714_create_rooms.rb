class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|
      t.integer :room_number
      t.string :room_type
      t.boolean :booked

      t.timestamps
    end
  end
end

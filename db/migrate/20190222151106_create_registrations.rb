class CreateRegistrations < ActiveRecord::Migration[5.2]
  def change
    create_table :registrations do |t|
      t.integer :user_id
      t.integer :channel_id
      t.integer :event_id
      t.string :notes
      t.timestamps
    end
  end
end

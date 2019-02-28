class CreateEventSeries < ActiveRecord::Migration[5.2]
  def change
    create_table :event_series do |t|
      t.integer :event_id
      t.string :schedule_type
      t.integer :schedule_length
      t.timestamps
    end
  end
end

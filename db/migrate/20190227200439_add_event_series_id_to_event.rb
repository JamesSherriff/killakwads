class AddEventSeriesIdToEvent < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :event_series_id, :integer
  end
end

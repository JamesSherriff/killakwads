class CreateJoinTableEventChannel < ActiveRecord::Migration[5.2]
  def change
    create_join_table :events, :channels do |t|
      t.index [:event_id, :channel_id]
    end
  end
end

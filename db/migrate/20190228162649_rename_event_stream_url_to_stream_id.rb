class RenameEventStreamUrlToStreamId < ActiveRecord::Migration[5.2]
  def change
    rename_column :events, :stream_url, :stream_id
  end
end

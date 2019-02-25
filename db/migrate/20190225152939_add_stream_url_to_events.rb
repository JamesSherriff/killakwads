class AddStreamUrlToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :stream_url, :string
  end
end

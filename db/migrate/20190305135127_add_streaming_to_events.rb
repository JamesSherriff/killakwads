class AddStreamingToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :streaming, :boolean, default: false
  end
end

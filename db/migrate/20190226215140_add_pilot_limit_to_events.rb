class AddPilotLimitToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :pilot_limit, :integer, default: 0
  end
end

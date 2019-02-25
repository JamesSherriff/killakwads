class ChangeEventEndToEventFinish < ActiveRecord::Migration[5.2]
  def change
    rename_column :events, :end, :finish
  end
end

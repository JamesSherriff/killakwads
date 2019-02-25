class AddDetailsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :description, :text
    add_column :users, :location, :text
    add_column :users, :display_name, :text
  end
end

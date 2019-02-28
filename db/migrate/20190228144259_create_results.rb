class CreateResults < ActiveRecord::Migration[5.2]
  def change
    create_table :results do |t|
      t.integer :result_set_id
      t.integer :user_id
      t.integer :position
      t.string :result
      t.timestamps
    end
  end
end

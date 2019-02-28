class CreateResultSets < ActiveRecord::Migration[5.2]
  def change
    create_table :result_sets do |t|
      t.integer :event_id
      t.string :name
      t.string :result_type
      t.timestamps
    end
  end
end

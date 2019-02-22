class AddRegistrationTimesToEvent < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :registration_start, :datetime
    add_column :events, :registration_end, :datetime
  end
end

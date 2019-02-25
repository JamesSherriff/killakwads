class AddChannelAllocationMethodToEvent < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :channel_allocation_method, :string
  end
end

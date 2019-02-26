class AddPilotBriefDownloadableToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :pilot_brief_downloadable, :boolean
  end
end

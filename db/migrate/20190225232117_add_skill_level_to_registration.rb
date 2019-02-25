class AddSkillLevelToRegistration < ActiveRecord::Migration[5.2]
  def change
    add_column :registrations, :skill_level, :string
  end
end

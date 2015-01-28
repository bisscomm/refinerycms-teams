class RenameTitleFieldToJobTitleInTeams < ActiveRecord::Migration
  def change
    rename_column :refinery_teams, :title, :job_title
  end
end
class AddJobtitleToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :jobtitle, :string
  end
end

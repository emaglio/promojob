class RemoveTitleFromJobs < ActiveRecord::Migration
  def change
    remove_column :jobs, :title, :string
  end
end

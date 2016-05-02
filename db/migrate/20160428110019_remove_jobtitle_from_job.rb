class RemoveJobtitleFromJob < ActiveRecord::Migration
  def change
    remove_column :jobs, :jobtilte, :string
  end
end

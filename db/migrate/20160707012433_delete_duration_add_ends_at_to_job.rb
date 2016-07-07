class DeleteDurationAddEndsAtToJob < ActiveRecord::Migration
  def change
    remove_column :jobs, :duration
    add_column :jobs, :ends_at, :datetime
  end
end

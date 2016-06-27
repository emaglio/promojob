class AddUserCountToJob < ActiveRecord::Migration
  def change
    add_column :jobs, :user_count, :integer
  end
end

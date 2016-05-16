class ChangeUsers < ActiveRecord::Migration

  def change
    remove_column :users, :password
    add_column :users, :auth_meta_data, :text
  end

end

class AddFileMetaDataToUser < ActiveRecord::Migration
  def change
    add_column :users, :file_meta_data, :text
  end
end

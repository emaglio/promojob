class CreateJobTable < ActiveRecord::Migration
  def change
  	
    create_table :jobs do |t|
      t.string :title
      t.string :company
      t.string :requirements
      t.string :description
      t.string :salary

      t.timestamps
    end
  end
end

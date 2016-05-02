class CreateJobApplications < ActiveRecord::Migration
  def change
    create_table :job_applications do |t|
      t.integer :job_id
      t.integer :user_id
      t.text :message
      t.string :status

      t.timestamps
    end
  end
end

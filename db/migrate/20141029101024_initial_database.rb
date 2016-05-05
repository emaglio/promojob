class InitialDatabase < ActiveRecord::Migration
  def change

    create_table :users do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.string :phone
      t.string :gender
      t.string :password

      t.timestamps
    end

    create_table :jobs do |t|
      t.string    :title
      t.string    :company
      t.text      :requirements
      t.text      :description
      t.string    :salary
      t.datetime  :starts_at

      t.timestamps
    end

  end
end

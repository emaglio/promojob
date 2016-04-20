class InitialDatabase < ActiveRecord::Migration
  def change

    create_table :users do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.string :phone
      t.string :gender

      t.timestamps
    end
    
  end
end

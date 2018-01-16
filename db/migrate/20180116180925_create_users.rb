class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :title
      t.string :name
      t.integer :gender
      t.string :email
      t.string :phone
      t.string :cel
      t.string :avatar

      t.timestamps
    end

    add_index :users, :name
    add_index :users, :email
  end
end

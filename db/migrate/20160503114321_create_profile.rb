class CreateProfile < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.string :last_name
      t.string :nickname
      t.string :email
      t.string :password
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :profiles, :users
    end
  end

class CreateOauthAccounts < ActiveRecord::Migration
  def change
    create_table :oauth_accounts do |t|
      t.references :user, index: true
      t.string :uid
      t.string :provider

      t.timestamps null: false
    end
    add_foreign_key :oauth_accounts, :users
  end
end

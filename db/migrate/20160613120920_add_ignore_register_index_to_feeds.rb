class AddIgnoreRegisterIndexToFeeds < ActiveRecord::Migration
  def change
    enable_extension :citext
    change_column :feeds, :url, :citext
    add_index :feeds, :url, unique: true
  end
end

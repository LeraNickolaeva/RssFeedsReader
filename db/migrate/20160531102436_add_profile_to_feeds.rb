class AddProfileToFeeds < ActiveRecord::Migration
  def change
    add_column :feeds, :profile_id, :integer
  end
end

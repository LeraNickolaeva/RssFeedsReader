class AddFeedToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :feed_id, :integer
  end
end

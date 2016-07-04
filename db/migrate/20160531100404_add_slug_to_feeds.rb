class AddSlugToFeeds < ActiveRecord::Migration
  def change
    add_column :feeds, :slug, :string, unique: true
  end
end

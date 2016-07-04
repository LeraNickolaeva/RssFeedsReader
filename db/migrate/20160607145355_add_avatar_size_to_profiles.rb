class AddAvatarSizeToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :avatar_size, :string, default: "basic"
  end
end

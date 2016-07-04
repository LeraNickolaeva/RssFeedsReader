class AddProfileTypeToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :profile_type, :string, default: "basic"
  end
end

class AddCoderwallDisplayInProfileToUsers < ActiveRecord::Migration[4.2]
  def self.up
    change_table :users do |t|
      t.boolean :coderwall_display_in_profile, :default => false
    end
    User.update_all ["coderwall_display_in_profile = ?", false]
  end

  def self.down
    remove_column :users, :coderwall_display_in_profile
  end
end

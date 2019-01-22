class AddCoderwallAliasToUsers < ActiveRecord::Migration[4.2]
  def self.up
    change_table :users do |t|
      t.string :coderwall_alias, :default => nil
    end
    User.update_all ["coderwall_alias = ?", nil]
  end

  def self.down
    remove_column :users, :coderwall_alias
  end
end

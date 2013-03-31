class ChangeColumnnameType < ActiveRecord::Migration
  def up
    rename_column :users, :type, :user_type => {:default => "0"}
  end

  def down
  end
end

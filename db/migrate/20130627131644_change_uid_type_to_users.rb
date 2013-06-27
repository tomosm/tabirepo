class ChangeUidTypeToUsers < ActiveRecord::Migration
  def up
    change_column :users, :uid, :int, :limit=>20
  end

  def down
  end
end

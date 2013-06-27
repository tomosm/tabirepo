class ChangeUidTypeToUsersForMysql < ActiveRecord::Migration
  def up
    change_column :users, :uid, :bigint
  end

  def down
  end
end

class AddSocialIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :social_id, :integer
  end
end

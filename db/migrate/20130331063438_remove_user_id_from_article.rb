class RemoveUserIdFromArticle < ActiveRecord::Migration
  def up
    remove_column :articles, :user_id
  end

  def down
    add_column :articles, :user_id, :string
  end
end

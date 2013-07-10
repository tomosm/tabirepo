class RemoveColumnPlanningIdFromArticles < ActiveRecord::Migration
  def up
    remove_column :articles, :planning_id
  end

  def down
  end
end

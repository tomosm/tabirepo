class AddColumnPlanningToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :planning_id, :integer
  end
end

class DropTableAnalyticsArticles < ActiveRecord::Migration
  def up
    drop_table :analytics_articles
  end

  def down
  end
end

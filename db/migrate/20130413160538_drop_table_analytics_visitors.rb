class DropTableAnalyticsVisitors < ActiveRecord::Migration
  def up
    drop_table :analytics_visitors
  end

  def down
  end
end

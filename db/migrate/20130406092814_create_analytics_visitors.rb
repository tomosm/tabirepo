class CreateAnalyticsVisitors < ActiveRecord::Migration
  def change
    create_table :analytics_visitors do |t|
      t.integer :date
      t.string :deviceregion
      t.string :visitorregion

      t.timestamps
    end
  end
end

class CreateAnalyticsArticles < ActiveRecord::Migration
  def change
    create_table :analytics_articles do |t|
      t.integer :article_id
      t.integer :date
      t.string :deviceregion
      t.string :visitorregion

      t.timestamps
    end
  end
end

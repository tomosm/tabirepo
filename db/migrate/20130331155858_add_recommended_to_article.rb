class AddRecommendedToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :recommended, :boolean
  end
end

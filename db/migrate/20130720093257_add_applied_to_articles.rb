class AddAppliedToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :applied, :boolean, :default => false
  end
end
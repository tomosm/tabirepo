class ChangeArticleStringTypeToText < ActiveRecord::Migration
  def up
    change_column :articles, :title, :text
    change_column :paragraphs, :subtitle, :text
    change_column :paragraphs, :sentence, :text
  end

  def down
  end
end

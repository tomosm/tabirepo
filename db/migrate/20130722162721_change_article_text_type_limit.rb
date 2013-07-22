class ChangeArticleTextTypeLimit < ActiveRecord::Migration
  def up
    change_column :articles, :title, :text, :limit=>nil
    change_column :paragraphs, :subtitle, :text, :limit=>nil
    change_column :paragraphs, :sentence, :text, :limit=>nil
  end

  def down
  end
end

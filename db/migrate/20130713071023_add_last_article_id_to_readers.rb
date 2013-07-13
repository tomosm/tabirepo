class AddLastArticleIdToReaders < ActiveRecord::Migration
  def change
    add_column :readers, :last_article_id, :integer
    remove_column :readers, :pre_reader_id
  end
end

class RemovePhotoFromArticle < ActiveRecord::Migration
  def up
    remove_column :articles, :photo_file_name
    remove_column :articles, :photo_content_type
    remove_column :articles, :photo_file_size
  end

  def down
  end
end

class AddPhotoToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :photo_file_name, :string
    add_column :articles, :photo_content_type, :string
    add_column :articles, :photo_file_size, :integer
  end
end

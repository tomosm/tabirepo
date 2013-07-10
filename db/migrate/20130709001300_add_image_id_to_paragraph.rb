class AddImageIdToParagraph < ActiveRecord::Migration
  def change
    add_column :paragraphs, :image_id, :integer
  end
end

class AddDeleteFlagToParagraph < ActiveRecord::Migration
  def change
    add_column :paragraphs, :deleted_at, :datetime
  end
end

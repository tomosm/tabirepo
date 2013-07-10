class RemoveEntryProgramFromArticles < ActiveRecord::Migration
  def up
    remove_column :articles, :entry_program
  end

  def down
  end
end

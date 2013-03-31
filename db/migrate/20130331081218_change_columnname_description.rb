class ChangeColumnnameDescription < ActiveRecord::Migration
  def up
    rename_column :articles, :description, :outline
  end

  def down
  end
end

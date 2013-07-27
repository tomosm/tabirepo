class AddPersonalToUsers < ActiveRecord::Migration
  def change
    add_column :users, :personal, :text
  end
end

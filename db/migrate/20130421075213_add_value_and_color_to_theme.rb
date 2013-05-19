class AddValueAndColorToTheme < ActiveRecord::Migration
  def change
    add_column :themes, :value, :string
    add_column :themes, :color, :string
  end
end

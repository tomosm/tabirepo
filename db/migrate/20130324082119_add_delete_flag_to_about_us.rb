class AddDeleteFlagToAboutUs < ActiveRecord::Migration
  def change
    add_column :about_us, :deleted_at, :datetime
  end
end

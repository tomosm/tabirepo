class CreateThemes < ActiveRecord::Migration
  def change
    create_table :themes do |t|
      t.string :code

      t.timestamps
    end
  end
end

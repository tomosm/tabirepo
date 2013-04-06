class CreateVisitors < ActiveRecord::Migration
  def change
    create_table :visitors do |t|
      t.integer :date
      t.string :deviceregion
      t.string :visitorregion

      t.timestamps
    end
  end
end

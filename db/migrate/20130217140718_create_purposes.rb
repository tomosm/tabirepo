class CreatePurposes < ActiveRecord::Migration
  def change
    create_table :purposes do |t|
      t.string :code

      t.timestamps
    end
  end
end

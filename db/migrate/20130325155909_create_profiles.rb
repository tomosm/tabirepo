class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.text :photo
      t.text :about

      t.timestamps
    end
  end
end

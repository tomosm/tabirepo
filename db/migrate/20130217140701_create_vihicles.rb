class CreateVihicles < ActiveRecord::Migration
  def change
    create_table :vihicles do |t|
      t.string :code

      t.timestamps
    end
  end
end

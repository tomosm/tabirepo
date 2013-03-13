class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :code

      t.timestamps
    end
  end
end

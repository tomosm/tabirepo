class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :description
      t.integer :theme_id
      t.integer :vihicle_id
      t.integer :member_id
      t.integer :purpose_id
      t.integer :budget_id
      t.integer :language_id
      t.integer :age_id
      t.boolean :entry_program

      t.timestamps
    end
  end
end

class CreateArticlePlannings < ActiveRecord::Migration
  def change
    create_table :article_plannings do |t|
      t.integer :article_id
      t.integer :planning_id

      t.timestamps
    end
  end
end

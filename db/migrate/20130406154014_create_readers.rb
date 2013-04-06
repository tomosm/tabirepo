class CreateReaders < ActiveRecord::Migration
  def change
    create_table :readers do |t|
      t.integer :article_id
      t.integer :date
      t.string :deviceregion
      t.string :visitorregion

      t.timestamps
    end
  end
end

class CreateSocials < ActiveRecord::Migration
  def change
    create_table :socials do |t|
      t.text :link

      t.timestamps
    end
  end
end

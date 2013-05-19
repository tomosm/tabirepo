class AddValueToVihicle < ActiveRecord::Migration
  def change
    add_column :vihicles, :value, :string
  end
end

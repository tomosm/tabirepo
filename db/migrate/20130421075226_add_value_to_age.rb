class AddValueToAge < ActiveRecord::Migration
  def change
    add_column :ages, :value, :string
  end
end

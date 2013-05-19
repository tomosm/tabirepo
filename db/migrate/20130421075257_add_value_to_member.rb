class AddValueToMember < ActiveRecord::Migration
  def change
    add_column :members, :value, :string
  end
end

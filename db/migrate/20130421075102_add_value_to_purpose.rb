class AddValueToPurpose < ActiveRecord::Migration
  def change
    add_column :purposes, :value, :string
  end
end

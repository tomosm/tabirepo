class AddValueToLanguage < ActiveRecord::Migration
  def change
    add_column :languages, :value, :string
  end
end

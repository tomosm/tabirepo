class AddTypeToUser < ActiveRecord::Migration
  def change
    add_column :users, :type, :string, default: "0"
    #add_column :users, :type => {:default => "0"}, :string,

  end
end

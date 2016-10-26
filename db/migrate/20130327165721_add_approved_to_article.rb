class AddApprovedToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :approved, :boolean, default: false
    #add_column :articles, :approved => {:default => false}, :boolean
  end
end

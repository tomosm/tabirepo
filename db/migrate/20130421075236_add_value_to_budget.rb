class AddValueToBudget < ActiveRecord::Migration
  def change
    add_column :budgets, :value, :string
  end
end

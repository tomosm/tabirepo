class CreateBudgets < ActiveRecord::Migration
  def change
    create_table :budgets do |t|
      t.string :code

      t.timestamps
    end
  end
end

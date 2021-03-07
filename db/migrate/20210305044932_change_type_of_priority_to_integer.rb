class ChangeTypeOfPriorityToInteger < ActiveRecord::Migration[6.1]
  def change
    remove_column :tasks, :priority
    add_column :tasks, :priority, :integer
  end
end

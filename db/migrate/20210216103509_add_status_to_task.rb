class AddStatusToTask < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :state, :string, default: 'pending'
  end
end

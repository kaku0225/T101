class AddEndTimeToTask < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :endtime, :datetime
  end
end

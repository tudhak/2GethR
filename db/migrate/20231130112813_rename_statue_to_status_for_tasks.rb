class RenameStatueToStatusForTasks < ActiveRecord::Migration[7.1]
  def change
    rename_column :tasks, :statue, :status
  end
end

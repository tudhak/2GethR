class AddCoupleToGenericTasks < ActiveRecord::Migration[7.1]
  def change
    add_reference(:generic_tasks, :couple, foreign_key: true)
  end
end

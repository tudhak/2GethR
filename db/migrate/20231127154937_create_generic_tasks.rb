class CreateGenericTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :generic_tasks do |t|
      t.string :title
      t.integer :base_score

      t.timestamps
    end
  end
end

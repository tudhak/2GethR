class AddDescriptionToGenericTasks < ActiveRecord::Migration[7.1]
  def change
    add_column :generic_tasks, :description, :string
  end
end

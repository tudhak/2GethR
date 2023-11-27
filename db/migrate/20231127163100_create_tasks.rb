class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.date :date
      t.integer :base_score
      t.references :user, null: false, foreign_key: true
      t.string :statue
      t.string :assigned_to
      t.string :done_by

      t.timestamps
    end
  end
end

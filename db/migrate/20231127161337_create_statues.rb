class CreateStatues < ActiveRecord::Migration[7.1]
  def change
    create_table :statues do |t|
      t.string :main_statue_message
      t.string :love_statue_message
      t.string :hate_statue_message
      t.references :mood_category, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
